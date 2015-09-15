package ${pojo.getPackageName()}.control;
<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName()) >
import ${pojo.importType(pojo.getPackageName()+'.model.'+pojo.getDeclarationName())};
<#foreach clases in  ctrlUtils.getFromParams(pojo,cfg)>
	 <#assign otros= pojo.importType(pojo.getPackageName()+'.model.'+clases)>
</#foreach>
/**
${pojo.getClassJavaDoc(pojo.getDeclarationName() + "ServiceImpl generated by UDA 1.0", 0)}, ${date}.
* @author UDA
 */
<#if annot!=0>@${pojo.importType("org.springframework.stereotype.Controller")}</#if>
@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")} (value = "/${pojo.getDeclarationName()?lower_case}")

public class ${pojo.getDeclarationName()}Controller  {

	private static final ${pojo.importType("org.apache.log4j.Logger")} logger = ${pojo.importType("org.apache.log4j.Logger")}.getLogger(${pojo.getDeclarationName()}Controller.class);

	<#if annot!=0>@${pojo.importType("org.springframework.beans.factory.annotation.Autowired")}</#if>
	private ${pojo.importType(pojo.getPackageName()+'.service.'+pojo.getDeclarationName()+'Service')} ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service;
	
	<#if annot!=0>@${pojo.importType("org.springframework.beans.factory.annotation.Autowired")}</#if>
	private ${pojo.importType("java.util.Properties")} appConfiguration;
	 /**
	 * Method 'getCreateForm'.
	 *
	 * @param model ${pojo.importType("org.springframework.ui.Model")}
	 * @return String
	 */
	@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")}(value = "maint", method = ${pojo.importType("org.springframework.web.bind.annotation.RequestMethod")}.GET)
	public ${pojo.importType("org.springframework.web.servlet.ModelAndView")} getCreateForm(${pojo.importType("org.springframework.ui.Model")} model) {
		model.addAttribute("defaultLanguage",
				appConfiguration.get("${warName}.default.language"));
		model.addAttribute("defaultLayout",
				appConfiguration.get("${warName}.default.layout"));
		return new ${pojo.importType("org.springframework.web.servlet.ModelAndView")}("${pojo.getDeclarationName()?lower_case}", "model", model);
	}

	<#assign camposDoc = ctrlUtils.getPrimaryKey(pojo,cfg)> 
	 /**
	 * Method 'getById'.
	 <#list camposDoc as camposPrim>
	 * @param  ${camposPrim[0]} ${pojo.importType(camposPrim[1])}
	 </#list>
	 * @return String
	 */
	<#assign primaria = ctrlUtils.getPrimaryKey(pojo,cfg)> 
	@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")}(value = "<#list primaria as camposPrim>/{${camposPrim[0]}}</#list>", method = ${pojo.importType("org.springframework.web.bind.annotation.RequestMethod")}.GET)
	<#assign primariaParam = ctrlUtils.getPrimaryKey(pojo,cfg)> 
	public @${pojo.importType("org.springframework.web.bind.annotation.ResponseBody")} ${pojo.getDeclarationName()} getById(<#list primariaParam as camposPrim>@${pojo.importType("org.springframework.web.bind.annotation.PathVariable")} ${pojo.importType(camposPrim[1])} ${camposPrim[0]}<#if camposPrim_has_next>, </#if></#list>) {
		try{
            ${pojo.getDeclarationName()} ${ctrl.stringDecapitalize(pojo.getDeclarationName())} = new ${pojo.getDeclarationName()}();
		<#if isJpa!=1>	
			<#foreach field in ctrlUtils.getPrimaryKeyCreator(pojo,cfg)>
				${ctrl.stringDecapitalize(pojo.getDeclarationName())}.set${pojo.beanCapitalize(field[0])};
			</#foreach>	
		<#else>
			<#if  clazz.getIdentifierProperty().isComposite()>
				${ctrl.stringDecapitalize(pojo.getDeclarationName())}.setId(new ${pojo.getDeclarationName()}Id());
			</#if>
		</#if>
		<#foreach field in ctrlUtils.getPrimaryKey(pojo,cfg)>
			${field[2]}.set${pojo.beanCapitalize(field[3])}(${field[0]});
		</#foreach>	
            ${ctrl.stringDecapitalize(pojo.getDeclarationName())} = this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service.find(${ctrl.stringDecapitalize(pojo.getDeclarationName())});
            if (${ctrl.stringDecapitalize(pojo.getDeclarationName())} == null) {
		  	<#assign primariaParamError = primariaParam> 
                throw new Exception(<#list primariaParamError as camposPrim>${camposPrim[0]}.toString()<#if camposPrim_has_next> + </#if></#list>);
            }
            return ${ctrl.stringDecapitalize(pojo.getDeclarationName())};
		}catch (Exception e){
		    throw new ${pojo.importType("com.ejie.x38.control.exception.ResourceNotFoundException")}(<#list primariaParamError as camposPrim>${camposPrim[0]}.toString()<#if camposPrim_has_next> + </#if></#list>);
		}
	}


	<#assign camposDoc = ctrlUtils.getPrimaryKey(pojo,cfg)> 
	 /**
	 * Method 'getAll'.
	 <#foreach field in  ctrlUtils.getPojoFieldsParameter(pojo,cfg)>
	*@param	  ${field[0]} ${pojo.importType(field[1])}
	</#foreach>
	*@param request ${pojo.importType("javax.servlet.http.HttpServletRequest")}
	 * @return String
	 */
	@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")}(method = ${pojo.importType("org.springframework.web.bind.annotation.RequestMethod")}.GET)
	public @${pojo.importType("org.springframework.web.bind.annotation.ResponseBody")} Object getAll(
	    <#foreach field in  ctrlUtils.getPojoFieldsParameter(pojo,cfg)>
@${pojo.importType("org.springframework.web.bind.annotation.RequestParam")}(value = "${field[0]}", required = false) ${pojo.importType(field[1])} ${field[0]},
		</#foreach>
			${pojo.importType("javax.servlet.http.HttpServletRequest")} request) {
			try{
			<#if isJpa!=1>	
				${pojo.getDeclarationName()} filter${pojo.getDeclarationName()} = ${ctrlUtils.getConstructor(pojo,cfg)};
			<#else>
				${pojo.getDeclarationName()} filter${pojo.getDeclarationName()} = ${ctrlUtils.getConstructor(pojo,cfg,true)};
			</#if>
                ${pojo.importType("com.ejie.x38.dto.Pagination")} pagination = null;
			    if (request.getHeader("JQGridModel") != null &&  request.getHeader("JQGridModel").equals("true")) {
				    pagination = new ${pojo.importType("com.ejie.x38.dto.Pagination")}();
				    pagination.setPage(Long.valueOf(request.getParameter("page")));
				    pagination.setRows(Long.valueOf(request.getParameter("rows")));
				    pagination.setSort(request.getParameter("sidx"));
				    pagination.setAscDsc(request.getParameter("sord"));
                    ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> ${ctrl.stringDecapitalize(pojo.getDeclarationName())}s =  this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service.findAll(filter${pojo.getDeclarationName()}, pagination);

     			    if (${ctrl.stringDecapitalize(pojo.getDeclarationName())}s == null) {
	    	            throw new Exception("No data Found.");
		            }
					
			        Long total =  getAllCount(filter${pojo.getDeclarationName()}, request);
				    ${pojo.importType("com.ejie.x38.dto.JQGridJSONModel")} data = new ${pojo.importType("com.ejie.x38.dto.JQGridJSONModel")}();
				    data.setPage(request.getParameter("page"));
				    data.setRecords(total.intValue());
				    data.setTotal(total, pagination.getRows());
				    data.setRows(${ctrl.stringDecapitalize(pojo.getDeclarationName())}s);
				    return data;
				}else{
				    ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> ${ctrl.stringDecapitalize(pojo.getDeclarationName())}s =  this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service.findAll(filter${pojo.getDeclarationName()}, pagination);
					if (${ctrl.stringDecapitalize(pojo.getDeclarationName())}s == null) {
	    	            throw new Exception("No data Found.");
		            }
				    return ${ctrl.stringDecapitalize(pojo.getDeclarationName())}s;
				}
            }catch(Exception e){
			    throw new ${pojo.importType("com.ejie.x38.control.exception.ResourceNotFoundException")}("No data Found.");
			}
	}

	/**
	 * Method 'getAllCount'.
	 * @param filter${pojo.getDeclarationName()} ${pojo.getDeclarationName()} 
	 * @param request  ${pojo.importType("javax.servlet.http.HttpServletRequest")}
	 * @return Long
	 */
	@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")}(value = "/count", method = ${pojo.importType("org.springframework.web.bind.annotation.RequestMethod")}.GET)
	public @${pojo.importType("org.springframework.web.bind.annotation.ResponseBody")} Long getAllCount(
	@${pojo.importType("org.springframework.web.bind.annotation.RequestParam")}(value = "${ctrl.stringDecapitalize(pojo.getDeclarationName())}", required = false) ${pojo.getDeclarationName()}  filter${pojo.getDeclarationName()}, ${pojo.importType("javax.servlet.http.HttpServletRequest")} request) {
	    try {
			return ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service
					.findAllCount(filter${pojo.getDeclarationName()} != null ? filter${pojo.getDeclarationName()}
							: new ${pojo.getDeclarationName()} ());
		} catch (Exception e) {
			throw new ${pojo.importType("com.ejie.x38.control.exception.ServiceUnavailableException")}("Count Service is not responding.");
		}
	}
	
	 /**
	 * Method 'edit'.
	 * @param	 ${ctrl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()} 
	 * @param response  ${pojo.importType("javax.servlet.http.HttpServletResponse")}
	 * @return ${pojo.getDeclarationName()}
	 */
	@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")}(method = ${pojo.importType("org.springframework.web.bind.annotation.RequestMethod")}.PUT)
    public @${pojo.importType("org.springframework.web.bind.annotation.ResponseBody")} ${pojo.getDeclarationName()} edit(@${pojo.importType("org.springframework.web.bind.annotation.RequestBody")} ${pojo.getDeclarationName()} ${ctrl.stringDecapitalize(pojo.getDeclarationName())}, ${pojo.importType("javax.servlet.http.HttpServletResponse")} response) {		
		try {
            ${pojo.getDeclarationName()} ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Aux  = this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service.update(${ctrl.stringDecapitalize(pojo.getDeclarationName())});
			logger.log(${pojo.importType("org.apache.log4j.Level")}.INFO, "Entity correctly inserted!");
            return ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Aux;
        } catch(Exception e) {
            throw new ${pojo.importType("com.ejie.x38.control.exception.MethodFailureException")}("Method failed");
        }
    }

	 /**
	 * Method 'add'.
	 * @param	 ${ctrl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()} 
	 * @return ${pojo.getDeclarationName()}
	 */
	@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")}(method = ${pojo.importType("org.springframework.web.bind.annotation.RequestMethod")}.POST)
	public @${pojo.importType("org.springframework.web.bind.annotation.ResponseBody")} ${pojo.getDeclarationName()} add(@${pojo.importType("org.springframework.web.bind.annotation.RequestBody")} ${pojo.getDeclarationName()} ${ctrl.stringDecapitalize(pojo.getDeclarationName())}) {		
        try {
            ${pojo.getDeclarationName()} ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Aux = this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service.add(${ctrl.stringDecapitalize(pojo.getDeclarationName())});
            logger.log(${pojo.importType("org.apache.log4j.Level")}.INFO, "Entity correctly inserted!");
        	return ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Aux;
		} catch(Exception e) {
        	throw new ${pojo.importType("com.ejie.x38.control.exception.MethodFailureException")}("Method failed");
		}
	}

	 /**
	 * Method 'remove'.
	<#foreach field in ctrlUtils.getPrimaryKey(pojo,cfg)> 
	 * @param  ${field[0]}  ${pojo.importType(field[1])}
	</#foreach>
	 * @param response  ${pojo.importType("javax.servlet.http.HttpServletResponse")}
	 *
	 */
	@${pojo.importType("org.springframework.web.bind.annotation.RequestMapping")}(value = "<#foreach field in ctrlUtils.getPrimaryKey(pojo,cfg)>/{${field[0]}}</#foreach>", method = ${pojo.importType("org.springframework.web.bind.annotation.RequestMethod")}.DELETE)
    public void remove(
				<#foreach field in ctrlUtils.getPrimaryKey(pojo,cfg)> 
				@${pojo.importType("org.springframework.web.bind.annotation.PathVariable")} ${pojo.importType(field[1])} ${field[0]},
				</#foreach>
					${pojo.importType("javax.servlet.http.HttpServletResponse")}  response) {
        response.setContentType("text/javascript;charset=utf-8");
        response.setHeader("Pragma", "cache");
        response.setHeader("Expires", "0");
        response.setHeader("Cache-Control", "private");
    	try{
            ${pojo.getDeclarationName()} ${ctrl.stringDecapitalize(pojo.getDeclarationName())} = new ${pojo.getDeclarationName()}();
			<#if isJpa!=1>	
				<#foreach field in ctrlUtils.getPrimaryKeyCreator(pojo,cfg)>
					${ctrl.stringDecapitalize(pojo.getDeclarationName())}.set${pojo.beanCapitalize(field[0])};
				</#foreach>	
			<#else>
				<#if  clazz.getIdentifierProperty().isComposite()>
					${ctrl.stringDecapitalize(pojo.getDeclarationName())}.setId(new ${pojo.getDeclarationName()}Id());
				</#if>
			</#if>
    	<#foreach field in ctrlUtils.getPrimaryKey(pojo,cfg)>
            ${field[2]}.set${pojo.beanCapitalize(field[3])}(${field[0]});
		</#foreach>	
            this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service.remove(${ctrl.stringDecapitalize(pojo.getDeclarationName())});
            response.setStatus(${pojo.importType("javax.servlet.http.HttpServletResponse")}.SC_OK);
    	} catch(Exception e) {
		<#assign error = ctrlUtils.getPrimaryKey(pojo,cfg)>
    		logger.log(${pojo.importType("org.apache.log4j.Level")}.ERROR, "Unable to delete " + <#list error as field> ${field[0]}<#if field_has_next> + </#if></#list>);
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
    		throw new ${pojo.importType("com.ejie.x38.control.exception.MethodFailureException")}("Method failed");
    	}
    }
	
	 /**
	 * Method 'removeAll'.
	 * @param  ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Ids  ${pojo.importType("java.util.ArrayList")}
	 * @param response  ${pojo.importType("javax.servlet.http.HttpServletResponse")}
	 *
	 */	
	@RequestMapping(value = "/deleteAll", method = RequestMethod.POST)
	public void removeMultiple(@RequestBody ${pojo.importType("java.util.ArrayList")}<${pojo.importType("java.util.ArrayList")}<String>> ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Ids,
			HttpServletResponse response) {
        response.setContentType("text/javascript;charset=utf-8");
        response.setHeader("Pragma", "cache");
        response.setHeader("Expires", "0");
        response.setHeader("Cache-Control", "private");
        ${pojo.importType("java.util.ArrayList")}<${pojo.getDeclarationName()}> ${ctrl.stringDecapitalize(pojo.getDeclarationName())}List = new ${pojo.importType("java.util.ArrayList")}<${pojo.getDeclarationName()}>();
        try{		    
            for (${pojo.importType("java.util.ArrayList")}<String> ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Id:${ctrl.stringDecapitalize(pojo.getDeclarationName())}Ids) {
			    ${pojo.importType("java.util.Iterator")}<String> iterator = ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Id.iterator();
				    ${pojo.getDeclarationName()} ${ctrl.stringDecapitalize(pojo.getDeclarationName())} = new ${pojo.getDeclarationName()}();
					<#if isJpa!=1>	
						<#foreach field in ctrlUtils.getPrimaryKeyCreator(pojo,cfg)>
							${ctrl.stringDecapitalize(pojo.getDeclarationName())}.set${pojo.beanCapitalize(field[0])};
						</#foreach>	
					<#else>
						<#if  clazz.getIdentifierProperty().isComposite()>
							${ctrl.stringDecapitalize(pojo.getDeclarationName())}.setId(new ${pojo.getDeclarationName()}Id());
						</#if>	
					</#if>
				<#assign parametros = ctrlUtils.getPrimaryKey(pojo,cfg)> 
				<#foreach field in parametros>					
			        ${field[2]}.set${pojo.beanCapitalize(field[3])}(${pojo.importType("com.ejie.x38.util.ObjectConversionManager")}.convert(iterator.next(), ${field[1]}.class));
		        </#foreach>
				    ${ctrl.stringDecapitalize(pojo.getDeclarationName())}List.add(${ctrl.stringDecapitalize(pojo.getDeclarationName())});
		    }
            this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service.removeMultiple(${ctrl.stringDecapitalize(pojo.getDeclarationName())}List);
			response.setStatus(HttpServletResponse.SC_OK);
		} catch(Exception e) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			throw new ${pojo.importType("com.ejie.x38.control.exception.MethodFailureException")}("Method failed");
		}
	}	

	/**
	 * Method 'handle'.
	 * @param e ${pojo.importType("com.ejie.x38.control.exception.ControlException")}
	 * @return String
	 *
	 */
	@${pojo.importType("org.springframework.web.bind.annotation.ExceptionHandler")}
	public @${pojo.importType("org.springframework.web.bind.annotation.ResponseBody")} String handle(${pojo.importType("com.ejie.x38.control.exception.ControlException")} e) {
		logger.log(${pojo.importType("org.apache.log4j.Level")}.WARN, e.getMessage());
		return e.getMessage();
	}

	/**
	 * Method 'get${pojo.getDeclarationName()}Service'.
	 *
	 * @return ${pojo.importType(pojo.getPackageName()+'.service.'+pojo.getDeclarationName()+'Service')}
	 *
	 */
	protected ${pojo.importType(pojo.getPackageName()+'.service.'+pojo.getDeclarationName()+'Service')} get${pojo.getDeclarationName()}Service() {
		return this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service;
	}

	/**
	 * Method 'set${pojo.getDeclarationName()}Service'.
	 *
	 * @param ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service  ${pojo.getDeclarationName()}Service
	 *
	 */
	public void set${pojo.getDeclarationName()}Service(${pojo.getDeclarationName()}Service ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service) {
		this.${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service = ${ctrl.stringDecapitalize(pojo.getDeclarationName())}Service;
	}
	
	/**
	 * Method 'getAppConfiguration'.
	 * 
	 * @return appConfiguration
	 * 
	 */
	public ${pojo.importType("java.util.Properties")} getAppConfiguration() {
		return appConfiguration;
	}

	/**
	 * Method 'setAppConfiguration'.
	 * 
	 * @paramappConfiguration Properties
	 * 
	 */
	public void setAppConfiguration(${pojo.importType("java.util.Properties")} appConfiguration) {
		this.appConfiguration = appConfiguration;
	}
<#foreach property in pojo.getAllPropertiesIterator()>
      <#if c2h.isManyToMany(property)>
        <#if c2h.isCollection(property)>
           <#include "controllerRelationsImpl.ftl"/>					
        </#if>
      </#if>
    </#foreach>	
}	
</#assign>

${pojo.generateImports()}
${classbody}	
