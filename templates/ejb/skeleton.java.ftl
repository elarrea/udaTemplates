<#-- 
 -- Copyright 2011 E.J.I.E., S.A.
 --
 -- Licencia con arreglo a la EUPL, Versión 1.1 exclusivamente (la «Licencia»);
 -- Solo podrá usarse esta obra si se respeta la Licencia.
 -- Puede obtenerse una copia de la Licencia en
 --
 --      http://ec.europa.eu/idabc/eupl.html
 --
 -- Salvo cuando lo exija la legislación aplicable o se acuerde por escrito, 
 -- el programa distribuido con arreglo a la Licencia se distribuye «TAL CUAL»,
 -- SIN GARANTÍAS NI CONDICIONES DE NINGÚN TIPO, ni expresas ni implícitas.
 -- Véase la Licencia en el idioma concreto que rige los permisos y limitaciones
 -- que establece la Licencia.
 -->
package ${packageNameSkeleton};
import javax.ejb.Stateless;
import javax.ejb.TransactionManagement;
import javax.ejb.TransactionManagementType;
import javax.interceptor.Interceptors;
import com.ejie.x38.remote.TransactionMetadataSkeletonInterceptor;
import org.springframework.ejb.interceptor.SpringBeanAutowiringInterceptor;
import javax.ejb.Remote;
import javax.ejb.TransactionAttribute;
import javax.ejb.TransactionAttributeType;
import com.ejie.x38.remote.TransactionMetadata;
import ${packageName}.${serviceName};
import org.springframework.beans.factory.annotation.Autowired;
<#foreach parametro in skeletonUtils.generateParameterImports(methods,isJpa)>	
    import ${parametro};
</#foreach>

/**
 * ${serviceName} + "Skeleton generated by UDA".
 * @author UDA
 */

@Stateless(mappedName = "${jndiName}")
@TransactionManagement(TransactionManagementType.CONTAINER)
@Interceptors({SpringBeanAutowiringInterceptor.class, TransactionMetadataSkeletonInterceptor.class})
@Remote(${serviceName}SkeletonRemote.class)
@TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
public class ${serviceName}Skeleton implements ${serviceName}SkeletonRemote   {
	@SuppressWarnings("unused")
    @Autowired
	private ${serviceName} ${ctrUtils.stringDecapitalize(serviceName)};
    <#assign param ="">
	<#assign listaMetodos = methods>
	<#list methods as metodo>
	    <#assign param = metodo[3]>
	/* Method ${metodo[0]}.
	 * <#foreach parametro in skeletonUtils.getParametersSkeleton(param,false,isJpa)>@param ${ctrUtils.stringDecapitalize(parametro)} ${parametro} </#foreach>
	 * @param  transactionMetadata TransactionMetadata
	 * @return <#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,isJpa)>${parametro}</#foreach>
	 */
	@Override
	${skeletonUtils.generateTransactionAttribute(metodo[0])}
	<#--public <#if isJpa><#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,isJpa)>${stubUtils.replaceDto(parametro)}</#foreach><#else>${metodo[2]}</#if> ${metodo[0]} (<#foreach parametro in skeletonUtils.getParametersSkeleton(param,false,isJpa)>${parametro} ${ctrUtils.stringDecapitalize(parametro)},</#foreach> TransactionMetadata transactionMetadata){-->
	public ${metodo[2]} ${metodo[0]} (<#foreach parametro in skeletonUtils.getParametersSkeleton(param,false,isJpa)>${parametro} ${ctrUtils.stringDecapitalize(parametro)}Var,</#foreach> TransactionMetadata transactionMetadata){
			<#if isJpa>
			  <#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,isJpa)><#if parametro!='void'>return</#if></#foreach> this.${ctrUtils.stringDecapitalize(serviceName)}.${metodo[0]}( <#list skeletonUtils.getParametersSkeleton(param,false,isJpa) as parametro><#if parametro!='Pagination' && parametro!='ArrayList' && parametro!='List'>new ${stubUtils.replaceDto(parametro)}(${ctrUtils.stringDecapitalize(parametro)}Var)<#else>${ctrUtils.stringDecapitalize(parametro)}Var</#if><#if parametro_has_next>,</#if></#list>);
			<#else>	
			  <#foreach parametro in skeletonUtils.getParametersSkeleton(metodo[1]+';',false,false)><#if parametro!='void'>return</#if></#foreach> this.${ctrUtils.stringDecapitalize(serviceName)}.${metodo[0]}( <#list skeletonUtils.getParametersSkeleton(param,false,isJpa) as parametro>${ctrUtils.stringDecapitalize(parametro)}Var<#if parametro_has_next>,</#if></#list>);
			</#if>
	}
	</#list>
	
	/**
	 * Method 'get${serviceName}'.
	 *
	 * @return ${serviceName}
	 */
	protected ${serviceName} get${serviceName}() {
		return this.${ctrUtils.stringDecapitalize(serviceName)};
	}

	/**
	 * Method 'set${serviceName}'.
	 *
	 * @param ${ctrUtils.stringDecapitalize(serviceName)}  ${serviceName}
	 * @return 
	 */
	public void set${serviceName}(${serviceName} ${ctrUtils.stringDecapitalize(serviceName)}) {
		this.${ctrUtils.stringDecapitalize(serviceName)} = ${ctrUtils.stringDecapitalize(serviceName)};
	}

}	