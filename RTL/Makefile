checkin:
	cp -rf yolo_params_include.sv cnn_top.sv const.sdc convolution.sv fully_connected_layer.sv max_pooling.sv relu.sv sigmoid.sv yolo_params_pkg.sv conv_mac.sv  max_func.sv neuron.sv sigmem.txt wt_mem.init Makefile  /drives/c/Users/EDE/OneDrive/Desktop/Masters/git/YOLO/RTL

synth:
	cp -rf cnn_top.sv yolo_params_include.sv const.sdc convolution.sv fully_connected_layer.sv max_pooling.sv relu.sv sigmoid.sv yolo_params_pkg.sv conv_mac.sv  max_func.sv neuron.sv sigmem.txt wt_mem.init Makefile  /drives/c/Users/EDE/OneDrive/Desktop/YOLO_SIM

synth_viv:
	C:/Xilinx/Vivado/2023.1/bin/vivado.bat -batch -source /drives/c/Users/EDE/OneDrive/Desktop/Masters/yolo_design/run_viv.tcl


