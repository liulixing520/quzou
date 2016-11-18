import org.ofbiz.entity.model.ModelReader;
dispatcher.getDispatchContext().loadNoCacheReaders();
ModelReader reader = delegator.getModelReader();
reader.getNoCacheEntityNames();
return "success";