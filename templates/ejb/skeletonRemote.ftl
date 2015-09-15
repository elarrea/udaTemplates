package ${packageNameSkeleton};
import javax.ejb.Remote;
import com.ejie.x38.dto.Pagination;
import com.ejie.x38.remote.TransactionMetadata;
<#foreach parametro in skeletonUtils.generateParameterImports(methods,isJpa)>
import ${parametro};
</#foreach>
@Remote
/**
* "${serviceName}SkeletonRemote generated by UDA 1.0".
* @author UDA
 */
public interface ${serviceName}SkeletonRemote{
	<#assign listaMetodos = methods >
	 <#assign param ="">
	<#list listaMetodos as metodo>
		   <#assign param = metodo[3]>
		   /*   method ${metodo[0]}.
		*<#foreach parametro in skeletonUtils.getParametersSkeleton(param,false,isJpa)>
		* @param ${ctrUtils.stringDecapitalize(parametro)} ${parametro} </#foreach>
		* @param  transactionMetadata TransactionMetadata
		* @return <#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,isJpa)>${parametro}</#foreach>
		*/
		${metodo[2]} ${metodo[0]} (  <#foreach parametro in skeletonUtils.getParametersSkeleton(param,false,isJpa)>${parametro} ${ctrUtils.stringDecapitalize(parametro)}Var,</#foreach>TransactionMetadata transactionMetadata);
	</#list>
}
