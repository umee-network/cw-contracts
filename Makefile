build-opt:
# https://github.com/CosmWasm/rust-optimizer
	docker run --rm -v "$(CURDIR)":/code \
	 --mount type=volume,source="$$(basename "$(CURDIR)")_cache",target=/code/target \
	 --mount type=volume,source=registry_cache,target=/usr/local/cargo/registry \
	 cosmwasm/workspace-optimizer:0.15.0

build:
#	@RUSTFLAGS='-C link-arg=-s' cargo +stable build --target wasm32-unknown-unknown --release --lib
	cargo build --target wasm32-unknown-unknown --release --lib
	@mkdir -p artifacts-local
	@cp target/wasm32-unknown-unknown/release/*.wasm ./artifacts-local

check:
	cosmwasm-check target/wasm32-unknown-unknown/release/*.wasm

unit-test:
	cargo test --lib
