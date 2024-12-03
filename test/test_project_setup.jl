include("../src/JifeUncertaintyQuantification.jl")

using .JifeUncertaintyQuantification

projectfile="TUC-V2_CS_red.xdj"
pathes = generatePossibleStochasticParameters(projectfile)

jmd = read(JifeModelDef, projectfile)

constant_b_param = findfirst(x->occursin("constant_b", x), pathes)
betaC_param = findfirst(x->occursin("betaC", x), pathes)
constant_k_param = findfirst(x->occursin("constant_k", x), pathes)
mEps_param = findfirst(x->occursin("mEps", x), pathes)
QDiffusion_param = findfirst(x->occursin("QDiffusion", x), pathes)

writeStochasticParameters(pathes[[constant_b_param, betaC_param, constant_k_param, mEps_param, QDiffusion_param]], "./StochasticParameters.xml")

simcall="/home/projects/Prestige/TUC-V2/ParameterStudie/dependencies/jife-app-6.5.0-SNAPSHOT/jife" # ogs binary has to be in path. otherwise insert your "path/to/ogs"
additionalprojecfilespath="./mesh"
outputpath="./Res"
postprocfiles=["PointHeatSource_quarter_002_2nd.xdmf"]
outputpath="./Res"
stochmethod=AdaptiveHierarchicalSparseGrid
n_workers = 30

stochparampathes = loadStochasticParameters("StochasticParameters.xml")

stochasticmodelparams = generateStochasticOGSModell(
	projectfile,
	simcall,
	additionalprojecfilespath,
	postprocfiles,
	stochparampathes,
	outputpath,
	stochmethod,
	n_workers)

stoch_params = stoch_parameters(stochasticmodelparams)
@assert contains(stoch_params[1].path, "betaC")
stoch_params[1].dist = Uniform(0.1,1.0)
stoch_params[1].lower_bound = 0.1
stoch_params[1].upper_bound = 1.0
@assert contains(stoch_params[2].path, "constant_b")
stoch_params[2].dist = Uniform(0.1,3.0)
stoch_params[2].lower_bound = 0.1
stoch_params[2].upper_bound = 3.0
@assert contains(stoch_params[3].path, "constant_k")
stoch_params[3].dist = Uniform(1.0,10.0)
stoch_params[3].lower_bound = 1.0
stoch_params[3].upper_bound = 1.0
@assert contains(stoch_params[4].path, "mEps")
stoch_params[4].dist = Uniform(0.1,10.0)
stoch_params[4].lower_bound = 0.1
stoch_params[4].upper_bound = 10.0
@assert contains(stoch_params[5].path, "QDiffusion")
stoch_params[5].dist = Uniform(35.0e6,55.0E6)
stoch_params[5].lower_bound = 35.0e6
stoch_params[5].upper_bound = 55.0e6

write(stochasticmodelparams)

samplemethodparams = generateSampleMethodModel(stochasticmodelparams)

#alter sample method params
samplemethodparams.RT = VTUFile #according to `fun` user_functions.jl
samplemethodparams.init_lvl = 3
samplemethodparams.maxlvl = 2
samplemethodparams.tol = 0.025

write(samplemethodparams)