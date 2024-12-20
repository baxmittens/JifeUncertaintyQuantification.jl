using JifeUncertaintyQuantification
import DelimitedFiles.writedlm

stochmodelparams = XML2Julia(read(XMLFile, "_ogsp_placeholder_"))
stoparams = stochmodelparams.stochparams
ogsparams = stochmodelparams.ogsparams
modeldef = read(JifeModelDef, ogsparams.projectfile)

user_functions = Function[x->x for i = 1:length(stoparams)]

function create_directories(ID, ogsparams)
	PATH = joinpath(ogsparams.outputpath,ID)
	if all(map(x->isfile(joinpath(PATH,x)),ogsparams.postprocfiles))
		return false
	end
	if !ispath(PATH)
		mkdir(PATH)
	end	
	return true
end

function create(x, ID, modeldef, ogsparams, stoparams)
		md = deepcopy(modeldef)
		name = split(modeldef.name,"/")[end]
		PATH = joinpath(ogsparams.outputpath,ID)
		rename!(md, joinpath(PATH,name))
		copyfiles =  readdir(ogsparams.additionalprojecfilespath)
		foreach(x->cp(joinpath(ogsparams.additionalprojecfilespath,x), joinpath(PATH,x), force=true), copyfiles)
		setStochasticParameters!(md, stoparams, x, user_functions)
		write(md)
		top = Any[]
		for stoparam in stoparams
			vals = getElementbyPath(md, stoparam.path)
			push!(top,vals.content[1])
		end
		writedlm(joinpath(PATH, "pars.txt"), top)
		writedlm(joinpath(PATH, "coords.txt"), x)
		return joinpath(PATH,name)
	end

function fun(x,ID, modeldef=modeldef, ogsparams=ogsparams, stoparams=stoparams)
	println(ID)
	if create_directories(ID, ogsparams)
		PATH = create(x,ID, modeldef, ogsparams, stoparams)
		println("ogs call @$x")
		ENV["OMP_NUM_THREADS"] = 1
		#run(pipeline(`$(ogsparams.simcall) -o $(joinpath(ogsparams.outputpath,ID)) $PATH`, joinpath(ogsparams.outputpath,ID,"out.txt")))
		run(pipeline(`$(ogsparams.simcall) -n -s 1 $PATH`, joinpath(ogsparams.outputpath,ID,"out.txt")))
		println("jife call finished")
	end
	res = VTUFile(joinpath(ogsparams.outputpath,ID,ogsparams.postprocfiles[end]))
	return res
end