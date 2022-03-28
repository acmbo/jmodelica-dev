# Jmodelica-dev
Jupyter Notebook Docker Container for development with JModelica


## Compile FMU inside Container

- pymodelica scans through folder which is definded in $MODELICAPATH. Path was set through Dockerfile and later changes inside the Container wont influence pymodelica
- dock additional librarys while startup the dockercontainer with additional volumes : `docker run -t -i -v <host_dir>:<container_dir>`
    - **PATH** to Modelica files inside Container: `'/usr/local/JModelica/ThirdParty/MSL/'`


```
import os

from pymodelica import compile_fmu
from pyfmi import load_fmu

# Directory is not always needed
curr_dir = os.path.dirname(os.path.abspath(__file__));

class_name = 'RLC_Circuit'
mofile = curr_dir+'/files/RLC_Circuit.mo'


# Direct to File
fmu_name = compile_fmu(class_name, mofile)


# If Library is already in MODELICAPATH
fmu_name = compile_fmu("Buildings.Controls.Sources.DayType") 


rlc = load_fmu(fmu_name)


```

## Usefull Commands inside Container

- printenv
- find / -name "theFile"
- container start: `docker run -v vscode:/hostdata -t -i jmtest1 /bin/bash`
- container start with attached library: `docker run -v /home/sim1/Programming/modelica-buildings/:/usr/local/JModelica/ThirdParty/MSL/ -t -i jmtest1 /bin/bash`
- Start JModelica in Python: https://marcobonvini.com/modelica/2017/01/02/modelica-in-action.html
- Load External Packages in Python: https://marcobonvini.com/modelica/2017/01/05/modelica-in-action-packages.html


## Requierements

- Jmodelica == 
- Modelica == 3.2.3 Library https://github.com/modelica/ModelicaStandardLibrary/releases/tag/v3.2.3%2Bbuild.4

