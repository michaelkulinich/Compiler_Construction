// const { readFileSync, writeFileSync } = require("fs");
// const wabt = require("wabt")();
// const path = require("path");
// require("wabt")().then(wabt => {

//     const inputWat = process.argv[2];
//     const outputWasm = inputWat.replace(/\.[^.]+$/, '.wasm');


//     const wasmModule = wabt.parseWat(inputWat, readFileSync(inputWat, "utf8"));
//     wasmModule.resolveNames();
//     wasmModule.validate();
//     const { buffer } = wasmModule.toBinary({});

//     writeFileSync(outputWasm, Buffer.from(buffer));

const { readFileSync, writeFileSync } = require("fs");
const path = require("path");
require("wabt")().then(wabt => {
    const inputWat = process.argv[2];
    const outputWasm = inputWat.replace(/\.[^.]+$/, '.wasm');

    try {
        const wasmModule = wabt.parseWat(inputWat, readFileSync(inputWat, "utf8"));
        wasmModule.resolveNames();
        wasmModule.validate();
        const { buffer } = wasmModule.toBinary({});

        writeFileSync(outputWasm, Buffer.from(buffer));
    } catch (error) {
        console.error(error);
        process.exitCode = 1;
    }
});