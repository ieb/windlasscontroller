/**
 * 
 * Mirrors Gcode in the X axies Assuming all movements are absolute. 
 * node mirrorGcode.js <input> <x mirror line>
 * eg 
 * node mirrorGcode.js back.ngc 60
 */ 


const fs = require('node:fs');

const file = process.argv[2];
const mirrorLine = parseFloat(process.argv[3]);
// read the file
const data = fs.readFileSync(file, 'utf8');
// find all X and replace with 2*mirror - x
const mirroredGCode = data.replace(/X(-?[0-9.]+)/mg, (match, x) => `X${2.0*mirrorLine - parseFloat(x)}`);
console.log(mirroredGCode);
