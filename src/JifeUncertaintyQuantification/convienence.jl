ogs6_modeldef(ogsparams::OGS6ProjectParams) = read(JifeModelDef, ogsparams.projectfile)
ogs6_modeldef(stochparams::StochasticOGSModelParams) = ogs6_modeldef(stochparams.ogsparams)
ogs6_modeldef(ogsuqparams::JifeUQParams) = ogs6_modeldef(ogsuqparams.stochasticmodelparams)
ogs6_modeldef(ogsuq::AbstractJifeUQ) = ogs6_modeldef(ogsuq.ogsuqparams)

ogs6_simcall(ogsparams::OGS6ProjectParams) = ogsparams.simcall
ogs6_simcall(stochparams::StochasticOGSModelParams) = ogs6_simcall(stochparams.ogsparams)
ogs6_simcall(ogsuqparams::JifeUQParams) = ogs6_simcall(ogsuqparams.stochasticmodelparams)
ogs6_simcall(ogsuq::AbstractJifeUQ) = ogs6_simcall(ogsuq.ogsuqparams)

ogs6_outputpath(ogsparams::OGS6ProjectParams) = ogsparams.outputpath
ogs6_outputpath(stochparams::StochasticOGSModelParams) = ogs6_outputpath(stochparams.ogsparams)
ogs6_outputpath(ogsuqparams::JifeUQParams) = ogs6_outputpath(ogsuqparams.stochasticmodelparams)
ogs6_outputpath(ogsuq::AbstractJifeUQ) = ogs6_outputpath(ogsuq.ogsuqparams)

ogs6_additionalprojecfilespath(ogsparams::OGS6ProjectParams) = ogsparams.additionalprojecfilespath
ogs6_additionalprojecfilespath(stochparams::StochasticOGSModelParams) = ogs6_additionalprojecfilespath(stochparams.ogsparams)
ogs6_additionalprojecfilespath(ogsuqparams::JifeUQParams) = ogs6_additionalprojecfilespath(ogsuqparams.stochasticmodelparams)
ogs6_additionalprojecfilespath(ogsuq::AbstractJifeUQ) = ogs6_additionalprojecfilespath(ogsuq.ogsuqparams)

ogs6_postprocfiles(stogsparamsochparams::OGS6ProjectParams) = ogsparams.postprocfiles
ogs6_postprocfiles(stochparams::StochasticOGSModelParams) = ogs6_postprocfiles(stochparams.ogsparams)
ogs6_postprocfiles(ogsuqparams::JifeUQParams) = ogs6_postprocfiles(ogsuqparams.stochasticmodelparams)
ogs6_postprocfiles(ogsuq::AbstractJifeUQ) = ogs6_postprocfiles(ogsuq.ogsuqparams)

stoch_parameters(stochasticmodelparams::StochasticOGSModelParams) = stochasticmodelparams.stochparams
stoch_parameters(ogsuqparams::JifeUQParams) = stoch_parameters(ogsuqparams.stochasticmodelparams)
stoch_parameters(ogsuq::AbstractJifeUQ) = stoch_parameters(ogsuq.ogsuqparams)

stoch_samplemethod(stochasticmodelparams::StochasticOGSModelParams) = stochasticmodelparams.samplemethod
stoch_samplemethod(ogsuqparams::JifeUQParams) = stoch_samplemethod(ogsuqparams.stochasticmodelparams)
stoch_samplemethod(ogsuq::AbstractJifeUQ) = stoch_samplemethod(ogsuq.ogsuqparams)