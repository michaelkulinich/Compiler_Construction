(module
 (import "env" "readInt" (func $readInt (result i32)))
 (import "env" "readDouble" (func $readDouble (result f64)))
 (import "env" "printInt" (func $printInt (param i32)))
 (import "env" "printDouble" (func $printDouble (param f64)))
 (func $main (result i32) (local $ix$0 i32))
 (func $dontCallMe (param $ix$0 i32) (result i32))
 (func $printBool (param $bb$0 i32))
 (func $implies (param $bx$0 i32) (param $by$0 i32) (result i32))
 (func $not (param $bx$0 i32) (result i32) (local $br$0 i32))
 (func $eq_bool (param $bx$0 i32) (param $by$0 i32) (result i32) (local $br$0 i32))
 (export "main" (func $main))
)