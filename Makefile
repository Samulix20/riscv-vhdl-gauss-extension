
build/riscv:
	@bash ./scripts/vhdl_comp.sh

sim: build/riscv
	@bash ./scripts/vhdl_sim.sh -t 8000us

test:
	@bash ./scripts/exec_tests.sh

clean:
	rm -rf build
