# Start the Container

First you need to start the Jmodelica Container through Docker. The Container has:
- JModelica Simulation Engine
- Dependend Modelica Libraries, which should be deployed into the "MSL" in of the JModelica folder
- Python interface
.. inside and will simulate youre Models. If you want to target your own libraries or other extern onesl you have to attach these libraries to the container. 

To start the container use docker through your commandline:

```
docker run -v /home/sim1/Programming/modelica-buildings/:/usr/local/JModelica/ThirdParty/MSL/ -t -i jmtest1 /bin/bash
```

Docker now runs the developmentcontainer _jmtest1_ with flags:
- v: to specifiy the volumes or the folder, which contain modelica librarys and after the :  where those libraries appear.
- t: Allocate a pseudo-tty
- i: Keep STDIN open even if not attached
- /bin/bash: starts with bash console inside container

optional:

- d: detached, runs in background of terminal


# Running a simulation throuhg bash inside the container

To start a simulation, start python within the container:

```
root@2927e54c1dd3: python
```

Afterwards you have to import a model and compile it into machine code for later simulation. Afterwards you run the simulation, which returns a array like result.


```
from pymodelica import compile_fmu
from pyfmi import load_fmu

# Compile model
fmu_name = compile_fmu("VDP","VDP.mo")
# Load model
vdp = load_fmu(fmu_name)

#simulate
res = vdp.simulate(final_time=10)

# results
x1 = res['x1']
x2 = res['x2']
t = res['time']
```

The compile_fmu command has severel ways to be executed. Dependen how you imported the model into JModelica, you can use `compile_fmu()` differently:
1.  Compile an example model from the MSL: You imported a Model through a whole Modelica library. Now you can use only 1 input with the standrad Modelica notation as a string:  `fmu1 = compile_fmu('Modelica.Mechanics.Rotational.Examples.First')`
2.  Compile with a direct path to library: `fmu2 = compile_fmu('MyLibrary.MyModel', '/MyLibs/MyLibrary')`
3.  Compile with a direct path to file of model: `fmu2 = compile_fmu('MyLibrary.MyModel', '/MyLibs/MyModel.mo')`

Be beware, that the path has to be set from the root of the MODELICAPATH, which is definde in your system or the docker container.

After compilation you can simulate and get the  results by simply following the code from above.


