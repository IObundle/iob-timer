# IOb-TIMER

IOb-TIMER is 64-bit hardware timer peripheral, equipped with reset, enable and
reading functions. It includes a software direver and an example C application.


## Clone the repository

``git clone --recursive git@github.com:IObundle/iob-timer.git``

## Simulation

To simulate:
```
make sim
```
To visualise simulation waveforms
```
make sim-waves
```
clean simulation files:
```
make sim-clean
```

## FPGA

To compile the FPGA:
```
make fpga
```

To clean FPGA files:
```
make fpga-clean
```
or to clean and delete 3rd party IP:
```
make fpga-clean-ip
```

## Documentation

To compile the chosen document type:
```
make doc [DOC_TYPE=[**pb**|ug]]
```

To clean document files:
```
make doc-clean
```

To clean document files including pdf files:
```
make doc-pdfclean
```

