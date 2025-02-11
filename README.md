# solana-program-atama

Multiple implementations of Atama Solana programs across languages: Rust, Zig, C, and
even assembly.

More programs will be added over time!


## Getting started

### Prerequisite for all languages

* Install Rust: https://www.rust-lang.org/tools/install

### Rust

* Install Solana tools

```console
./install-solana.sh
```



```console
cd helloworld
```

* Build a program

```console
cargo build-sbf
```

* Test a program

```console
cargo test-sbf
```

### Zig

* Get the compiler

```console
./install-solana-zig.sh
```

* Go to the Zig implementation of a program

```console
cd atama/zig
```

* Build the program

```console
../../solana-zig/zig build
```

* Test it

```console
cd ..
SBF_OUT_DIR="./zig/zig-out/lib" cargo test
```

* OR use the helper from the root of this repo to build and test

```console
./test-zig.sh atama
```

### C

* Install Solana C compiler

```console
./install-solana-c.sh
```

* Install Solana tools

```console
./install-solana.sh
```

* Go to a program directory

```console
cd atama/c
```

* Build a program

```console
make
```

* Test it

```console
cd ..
SBF_OUT_DIR="./c/out" cargo test
```

* OR use the helper from the root of this repo to build and test

```console
./test-c.sh atama
```

### Assembly

* Install Solana LLVM tools

```console
./install-solana-llvm.sh
```

* Go to a program directory

```console
cd atama/asm
```

* Build a program

```console
make
```

* Test it

```console
cd ..
SBF_OUT_DIR="./asm/out" cargo test
```

* OR use the helper from the root of this repo to build and test

```console
./test-asm.sh atama
```

## Current Programs


### Transfer-Lamports

Moves lamports from a source account to a destination, with the amount given by
a little-endian u64 in instruction data.

| Language | CU Usage |
| --- | --- |
| Rust | 459 |
| Zig | 38 |
| C | 104 |
| Assembly | 30 |
| Rust (atama) | 32 |

This one starts to get interesting since it requires parsing the instruction
input. Since the assembly version knows exactly where to find everything, it can
be hyper-optimized. The atama version performs very closely to the assembly
implementation!

### CPI

Allocates a PDA given by the seed "You pass butter" and a bump seed in the
instruction data. This requires a call to `create_program_address` to check the
address and `invoke_signed` to CPI to the system program.

| Language | CU Usage | CU Usage (minus syscalls) |
| --- | --- | --- |
| Rust | 3698 | 1198 |
| Zig | 2825 | 325 |
| C | 3122 | 622 |
| Rust (atama) | 2816 | 316 |

Note: `create_program_address` consumes 1500 CUs, and `invoke` consumes 1000, so
we can subtract 2500 CUs from each program to see the actual cost of the program
logic.

### Pubkey

A program to compare two `Pubkey` instances. This operation is very common in
on-chain programs, but it can be expensive.

| Language | CU Usage |
| --- | --- |
| Rust | 14 |
| Zig | 15 |


