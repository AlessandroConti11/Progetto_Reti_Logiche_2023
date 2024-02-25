# Test_Bench folder


The folder contains all the test benches that were developed and used to verify the accurate implementation of the module.

- [tb_example23_agg](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/tb_example23_agg.vhd) is the example test bench provided by the professor.
- [empty_address](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/empty_address.vhd) tests the behavior of the component when the memory address is empty.
- [full_address](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/full_address.vhd) tests the behavior of the component when the memory address is full.
- [show_out](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/show_out.vhd) tests whether the component correctly displays the word read from memory in the right output channel.
- [all_outs](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/all_outs.vhd) tests whether the component shows data on all outputs (all outputs are selected).
- [all_outs_with_overwrite](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/all_outs_with_overwrite.vhd) tests whether the component shows data on all outputs and changes them when they are overwritten (all outputs are selected).
- [reset_start_1](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/reset_start_1.vhd) tests the behavior of the component when reset occurs when start is high.
- [reset_ask_mem](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/reset_ask_mem.vhd) tests the behavior of the component when reset occurs in the data request phase from memory.
- [reset_read_mem](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/reset_read_mem.vhd) tests the behavior of the component when the reset occurs in the read data from memory phase.
- [save_out](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/save_out.vhd) tests the behavior of the component when reset occurs in the output write phase of the data read from memory.
- [complete_long](https://github.com/AlessandroConti11/Progetto_Reti_Logiche_2023/blob/main/Specification/Test_Bench/complete_long.vhd) is the component stress test.
