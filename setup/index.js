
const { SerialPortStream } = require('@serialport/stream');
const { autoDetect } = require('@serialport/bindings-cpp');
const { ReadlineParser } = require('@serialport/parser-readline');

const binding = autoDetect();


class Jdy40Control {
  static get baudLookup() {
    return {
      1200: '1',
      2400: '2',
      4800: '3',
      9600: '4',
      14400: '5',
      19200: '6',
    };
  }

  constructor(opts) {
    this.port = new SerialPortStream({
      binding,
      path: opts.serialdevice,
      baudRate: opts.baud,
    });

    this.port.on('error', (err) => {
      console.log('Error: ', err.message);
    });

    const parser = this.port.pipe(new ReadlineParser({ delimiter: '\r\n' }));

    this.defaultReciever = console.log;
    this.reciever = this.defaultReciever;
    parser.on('data', (line) => {
      this.reciever(line);
    });
  }

  close() {
    this.port.close();
  }


  async writeCommand(command, cb) {
    const ret = await new Promise((resolve, reject) => {
      console.log('>', command);
      setTimeout(() => {
        this.port.write(`${command}\r\n`, (err) => {
          if (err) {
            console.log('Error on write: ', err.message);
            reject(err);
          } else {
            this.reciever = (response) => {
              if (cb(response)) {
                this.reciever = this.defaultReciever;
                resolve();
              }
            };
          }
        });
      }, 100);
    });
    return ret;
  }

  async sendSequence(commandSequence) {
    for (let i = 0; i < commandSequence.length; i++) {
      // eslint-disable-next-line no-await-in-loop
      await this.writeCommand(commandSequence[i].send, (line) => {
        if (line.startsWith(commandSequence[i].expect)) {
          console.log('Got ', line);
          return true;
        }
        console.log('Expecting +BAUD=... ', line);
        return false;
      });
    }
  }
}

const showHelp = () => {
  console.log('Jdy40Programmer ');
  console.log('-h                   this help');
  console.log('-p <serialdevice>    Serial device eg /dev/cu.usbserial-A50285BI');
  console.log('-b <baud>            Baud Rate, default 9600');
  console.log('-sb <baud>           Switch Baud rate ');
  console.log('-status              Dump current status ');
  console.log('-t transmitter|base  Configure as transmitter or base ');
  console.log('-did <deviceid>      Set the device id, default 1123, 0000-FFFF) ');
  console.log('-rid <rfid>          Set the RFID id, default 1021, 0000-FFFF) ');
  console.log('-cid <chid>          Set the Channel ID, default 001, 001-128 ');
  console.log('-power <chid>        Set the Power, default 9, 0-9, 0 == -25db 9 == +12db ');
  process.exit();
};


let i = 1;
const options = {
  serialdevice: '/dev/cu.usbserial-A50285BI',
  baud: 9600,
  did: '1123',
  rid: '1021',
  cid: '001',
  power: '9',
};
let valid = false;
while (i < process.argv.length) {
  const v = process.argv[i];
  if (v === '-h') {
    showHelp();
  } else if (v === '-status') {
    valid = true;
    options.status = true;
  } else if (v === '-p') {
    valid = true;
    i++;
    options.baud = parseInt(process.argv[i], 10);
  } else if (v === '-sb') {
    i++;
    options.setBaud = Jdy40Control.baudLookup[process.argv[i]];
    if (options.setBaud) {
      valid = true;
    }
  } else if (v === '-t') {
    i++;
    options.mode = process.argv[i];
    if (options.mode === 'transmitter' || options.mode === 'base') {
      valid = true;
    }
  } else if (v === '-did') {
    i++;
    options.did = process.argv[i];
  } else if (v === '-rid') {
    i++;
    options.rid = process.argv[i];
  } else if (v === '-cid') {
    i++;
    options.cid = process.argv[i];
  } else if (v === '-power') {
    i++;
    options.power = process.argv[i];
  }
  i++;
}
if (!valid) {
  showHelp();
}




const queryStatus = async (jdy40) => {
  await jdy40.sendSequence([
    { send: 'AT+BAUD', expect: '+BAUD=' },
    { send: 'AT+RFID', expect: '+RFID=' },
    { send: 'AT+DVID', expect: '+DVID=' },
    { send: 'AT+RFC', expect: '+RFC=' },
    { send: 'AT+POWE', expect: '+POWE=' },
    { send: 'AT+CLSS', expect: '+CLSS=' },
  ]);
};

const setBaud = async (jdy40,opts) => {
  await jdy40.sendSequence([
    { send: `AT+BAUD${opts.setBaud}`, expect: 'OK' },
    { send: 'AT+BAUD', expect: `+BAUD=${opts.setBaud}` },
  ]);
};

const setupSender = async (jdy40, opts) => {
  await jdy40.sendSequence([
    { send: 'AT+CLSSC0', expect: 'OK' },
    { send: 'AT+CLSS', expect: '+CLSS=C0' },
    { send: `AT+RFID${opts.rid}`, expect: 'OK' },
    { send: 'AT+RFID', expect: `+RFID=${opts.rid}` },
    { send: `AT+DVID${opts.did}`, expect: 'OK' },
    { send: 'AT+DVID', expect: `+DVID=${opts.did}` },
    { send: `AT+RFC${opts.cid}`, expect: 'OK' },
    { send: 'AT+RFC', expect: `+RFC=${opts.cid}` },
    { send: `AT+POWE${opts.power}`, expect: 'OK' },
    { send: 'AT+POWE', expect: `+POWE=${opts.power}` },
  ]);
};

const setupBase = async (jdy40, opts) => {
  await jdy40.sendSequence([
    { send: 'AT+CLSSC4', expect: 'OK' },
    { send: 'AT+CLSS', expect: '+CLSS=C4' },
    { send: `AT+RFID${opts.rid}`, expect: 'OK' },
    { send: 'AT+RFID', expect: `+RFID=${opts.rid}` },
    { send: `AT+DVID${opts.did}`, expect: 'OK' },
    { send: 'AT+DVID', expect: `+DVID=${opts.did}` },
    { send: `AT+RFC${opts.cid}`, expect: 'OK' },
    { send: 'AT+RFC', expect: `+RFC=${opts.cid}` },
    { send: `AT+POWE${opts.power}`, expect: 'OK' },
    { send: 'AT+POWE', expect: `+POWE=${opts.power}` },
  ]);
};

const runCommand = async (opts) => {
  const jdy40 = new Jdy40Control(opts);
  if (opts.status) {
    await queryStatus(jdy40);
  } else if (opts.mode === 'transmitter') {
    await setupSender(jdy40, opts);
  } else if (opts.mode === 'base') {
    await setupBase(jdy40, opts);
  } else if (opts.setBaud) {
    await setBaud(jdy40, opts);
  } else {
    console.log('No operation requested');
  }
  jdy40.close();
};

runCommand(options).then(() => {
  console.log('Done');
});

