# A Turing Machine intepreter

## Syntax Demo
```
b None Pe R  Pe R P0 R R P0 L L o
o 1    R  Px L  L L             o
o 0                             q
q Any  R  R                     q
q None P1 L                     p
p x    E  R                     q
p e    R                        f
p None L  L                     p
f Any  R  R                     f
f None P0 L  L                  o
```
This will compute the transcedental number 0.001011011101111011111...

## Language Specification
first column is start-state, then the scanned symbol, then arbitrary many
moves (actions) corresponding to the scanned symbol and start-state. The 
last column is switching column, after all actions are executed, the machine
switch to this state.

## Usage
```
cd path/to/src
lua main.lua <turing machine file> <start state>
```
Then enjoy!
