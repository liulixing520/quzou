import org.extErp.sysCommon.party.CommonWorkers;

if(pCtx.departmentId){
	deptList = CommonWorkers.getChildPartyGroupAndCurrentByGroupIds(delegator,pCtx.departmentId)
	context.pCtx.partyId = CommonWorkers.getUserPartyIdByGroupIds(delegator,null,deptList)
	context.pCtx.partyId_op = "in"

	context.pCtx.departmentId = null
}