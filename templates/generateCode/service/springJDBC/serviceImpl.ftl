<#-- 
 -- Copyright 2013 E.J.I.E., S.A.
 --
 -- Licencia con arreglo a la EUPL, VersiÃ³n 1.1 exclusivamente (la Â«LicenciaÂ»);
 -- Solo podrÃ¡ usarse esta obra si se respeta la Licencia.
 -- Puede obtenerse una copia de la Licencia en
 --
 --      http://ec.europa.eu/idabc/eupl.html
 --
 -- Salvo cuando lo exija la legislaciÃ³n aplicable o se acuerde por escrito, 
 -- el programa distribuido con arreglo a la Licencia se distribuye Â«TAL CUALÂ»,
 -- SIN GARANTÃ�AS NI CONDICIONES DE NINGÃšN TIPO, ni expresas ni implÃ­citas.
 -- VÃ©ase la Licencia en el idioma concreto que rige los permisos y limitaciones
 -- que establece la Licencia.
 -->
package ${pojo.getPackageName()}.service;
<#assign classbody><#assign declarationName = pojo.importType(pojo.getDeclarationName()) >
import ${pojo.importType(pojo.getPackageName()+'.model.'+pojo.getDeclarationName())};
<#-- calculamos los campos para luego no tener que estar recorrer el array -->

/**
${pojo.getClassJavaDoc(pojo.getDeclarationName() + "ServiceImpl generated by UDA", 0)}, ${date}.
 * @author UDA
 */

<#if annot!=0>@${pojo.importType("org.springframework.stereotype.Service")}(value = "${ctrTl.stringDecapitalize(pojo.getDeclarationName())}Service")</#if>
public class ${pojo.getDeclarationName()}ServiceImpl implements ${pojo.getDeclarationName()}Service {
	<#if annot==0>
	
	private static final ${pojo.importType("org.slf4j.Logger")} logger = ${pojo.importType("org.slf4j.LoggerFactory")}.getLogger(${pojo.getDeclarationName()}ServiceImpl.class);
	</#if>

	<#if annot!=0>@${pojo.importType("org.springframework.beans.factory.annotation.Autowired")}</#if>
	private ${pojo.importType(pojo.getPackageName()+'.dao.'+pojo.getDeclarationName()+'Dao')} ${ctrTl.stringDecapitalize(pojo.getDeclarationName())}Dao;
    <#assign nombreDao ='${ctrTl.stringDecapitalize(pojo.getDeclarationName())}'+'Dao' >

	/**
	 * Inserts a single row in the ${pojo.getDeclarationName()} table.
	 *
	 * @param ${ctrTl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()}
	 * @return ${pojo.getDeclarationName()}
	 */
	@${pojo.importType("org.springframework.transaction.annotation.Transactional")}(rollbackFor = Throwable.class)
	public ${pojo.getDeclarationName()} add(${pojo.getDeclarationName()} ${ctrTl.stringDecapitalize(pojo.getDeclarationName())}) {
		return this.${nombreDao}.add(${ctrTl.stringDecapitalize(pojo.getDeclarationName())});
	}

	/**
	 * Updates a single row in the ${pojo.getDeclarationName()} table.
	 *
	 * @param ${ctrTl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()}
	 * @return ${pojo.getDeclarationName()}
	 */
	@${pojo.importType("org.springframework.transaction.annotation.Transactional")}(rollbackFor = Throwable.class)
	public ${pojo.getDeclarationName()} update(${pojo.getDeclarationName()} ${ctrTl.stringDecapitalize(pojo.getDeclarationName())}) {
		return this.${nombreDao}.update(${ctrTl.stringDecapitalize(pojo.getDeclarationName())});
	 }

	/**
	 * Finds a single row in the ${pojo.getDeclarationName()} table.
	 *
	 * @param ${ctrTl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()}
	 * @return ${pojo.getDeclarationName()}
	 */
	public ${pojo.getDeclarationName()} find(${pojo.getDeclarationName()} ${ctrTl.stringDecapitalize(pojo.getDeclarationName())}) {
		return (${pojo.getDeclarationName()}) this.${nombreDao}.find(${ctrTl.stringDecapitalize(pojo.getDeclarationName())});
	}
	
	/**
	 * Deletes a single row in the ${pojo.getDeclarationName()} table.
	 *
	 * @param ${ctrTl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()}
	 */
	@${pojo.importType("org.springframework.transaction.annotation.Transactional")}(rollbackFor = Throwable.class)
	public void remove(${pojo.getDeclarationName()} ${ctrTl.stringDecapitalize(pojo.getDeclarationName())}) {
		this.${nombreDao}.remove(${ctrTl.stringDecapitalize(pojo.getDeclarationName())});
	}

	/**
	 * Finds a list of rows in the ${pojo.getDeclarationName()} table.
	 *
	 * @param ${ctrTl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
	 * @return ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}>
	 */
	public ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAll(${pojo.getDeclarationName()} ${ctrTl.stringDecapitalize(pojo.getDeclarationName())}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto){
		return (${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}>) this.${nombreDao}.findAll(${ctrTl.stringDecapitalize(pojo.getDeclarationName())}, tableRequestDto);
	}
    
	/**
	 * Finds rows in the ${pojo.getDeclarationName()} table using like.
	 *
	 * @param ${ctrTl.stringDecapitalize(pojo.getDeclarationName())} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
     * @param startsWith Boolean	 
	 * @return ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}>
	 */
	public ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAllLike(${pojo.getDeclarationName()} ${ctrTl.stringDecapitalize(pojo.getDeclarationName())}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto, Boolean startsWith){
		return (${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}>) this.${nombreDao}.findAllLike(${ctrTl.stringDecapitalize(pojo.getDeclarationName())}, tableRequestDto, startsWith);
	}

	/*
	 * OPERACIONES RUP_TABLE
	 */
	 
	/**
	 * Removes rows from the ${pojo.getDeclarationName()} table.
	 *
	 * @param filter${pojo.getDeclarationName()} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
	 * @param startsWith Boolean
	 */	
	public void removeMultiple(${pojo.getDeclarationName()} filter${pojo.getDeclarationName()}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto,  Boolean startsWith){
		this.${nombreDao}.removeMultiple(filter${pojo.getDeclarationName()}, tableRequestDto, startsWith);
	}
        
	/**
	 * Filter method in the ${pojo.getDeclarationName()} table.
	 *
	 * @param filter${pojo.getDeclarationName()} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
	 * @param startsWith Boolean
	 * @return ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.getDeclarationName()}>
	 */	
	public ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}< ${pojo.getDeclarationName()}> filter(${pojo.getDeclarationName()} filter${pojo.getDeclarationName()}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto,  Boolean startsWith){
		${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> lista${pojo.getDeclarationName()} =  this.${nombreDao}.findAllLike(filter${pojo.getDeclarationName()}, tableRequestDto, false);
		Long recordNum =  this.${nombreDao}.findAllLikeCount(filter${pojo.getDeclarationName()} != null ? filter${pojo.getDeclarationName()}: new ${pojo.getDeclarationName()} (),false);
		if (tableRequestDto.getMultiselection().getSelectedIds()!=null){
			${pojo.importType("java.util.List")}< ${pojo.importType("com.ejie.x38.dto.TableRowDto")}< ${pojo.getDeclarationName()}>> reorderSelection = this.${nombreDao}.reorderSelection(filter${pojo.getDeclarationName()}, tableRequestDto, startsWith);
			return new ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.getDeclarationName()}>(tableRequestDto, recordNum, lista${pojo.getDeclarationName()}, reorderSelection);
		}
		return new TableResponseDto<${pojo.getDeclarationName()}>(tableRequestDto, recordNum, lista${pojo.getDeclarationName()});   
	}
    
    /**
	 * Searches rows in the ${pojo.getDeclarationName()} table.
	 *
	 * @param filter${pojo.getDeclarationName()} ${pojo.getDeclarationName()}
	 * @param search${pojo.getDeclarationName()} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
	 * @param startsWith Boolean
	 * @return ${pojo.importType("java.util.List")}<${pojo.importType("com.ejie.x38.dto.TableRowDto")}<${pojo.getDeclarationName()}>>
	 */	
    public ${pojo.importType("java.util.List")}< ${pojo.importType("com.ejie.x38.dto.TableRowDto")}< ${pojo.getDeclarationName()}>> search(${pojo.getDeclarationName()} filter${pojo.getDeclarationName()}, ${pojo.getDeclarationName()} search${pojo.getDeclarationName()}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto, Boolean startsWith){
		return this.${nombreDao}.search(filter${pojo.getDeclarationName()}, search${pojo.getDeclarationName()}, tableRequestDto, startsWith);
	}
    
    /**
	 * Reorder the selection made in ${pojo.getDeclarationName()} table.
	 *
	 * @param filter${pojo.getDeclarationName()} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
	 * @param startsWith Boolean
	 * @return ${pojo.importType("java.lang.Object")}
	 */	
    public ${pojo.importType("java.lang.Object")} reorderSelection(${pojo.getDeclarationName()} filter${pojo.getDeclarationName()}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto, Boolean startsWith){
		return this.${nombreDao}.reorderSelection(filter${pojo.getDeclarationName()}, tableRequestDto, startsWith);
	}
    
    /*
	 * OPERACIONES RUP_TABLE JERARQUIA
	 */
	 
	/**
	 * Finder method in the hierarchical the ${pojo.getDeclarationName()} table.
	 *
	 * @param filter${pojo.getDeclarationName()} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
	 * @param startsWith Boolean
	 * @return ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.importType("com.ejie.x38.dto.JerarquiaDto")}<${pojo.getDeclarationName()}>>
	 */	
	public ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.importType("com.ejie.x38.dto.JerarquiaDto")}<${pojo.getDeclarationName()}>> jerarquia(${pojo.getDeclarationName()} filter${pojo.getDeclarationName()}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto, Boolean startsWith){
		List<${pojo.importType("com.ejie.x38.dto.JerarquiaDto")}<${pojo.getDeclarationName()}>> lista${pojo.getDeclarationName()} =  this.${nombreDao}.findAllLikeJerarquia(filter${pojo.getDeclarationName()}, tableRequestDto);
		Long recordNum = this.${nombreDao}.findAllLikeCountJerarquia(filter${pojo.getDeclarationName()}, tableRequestDto);
		return new TableResponseDto<JerarquiaDto<${pojo.getDeclarationName()}>>(tableRequestDto, recordNum, lista${pojo.getDeclarationName()});
	}
	
	/**
	 * Finder method for siblings rows in the hierarchical the ${pojo.getDeclarationName()} table.
	 *
	 * @param filter${pojo.getDeclarationName()} ${pojo.getDeclarationName()}
	 * @param tableRequestDto ${pojo.importType("com.ejie.x38.dto.TableRequestDto")}
	 * @return ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.importType("com.ejie.x38.dto.JerarquiaDto")}<${pojo.getDeclarationName()}>>
	 */	
	public ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.importType("com.ejie.x38.dto.JerarquiaDto")}<${pojo.getDeclarationName()}>> jerarquiaChildren(${pojo.getDeclarationName()} filter${pojo.getDeclarationName()}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto){
		${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.importType("com.ejie.x38.dto.JerarquiaDto")}<${pojo.getDeclarationName()}>> tableResponseDto = new ${pojo.importType("com.ejie.x38.dto.TableResponseDto")}<${pojo.importType("com.ejie.x38.dto.JerarquiaDto")}<${pojo.getDeclarationName()}>>();
		tableResponseDto.addAdditionalParam(TableResponseDto.CHILDREN, this.${nombreDao}.findAllChild(filter${pojo.getDeclarationName()}, tableRequestDto));
		return tableResponseDto;
	}
	
	/**
    * Exporta Datos al clipBoard
    *
    */
    public ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> getMultiple(${pojo.getDeclarationName()} filter${pojo.getDeclarationName()}, ${pojo.importType("com.ejie.x38.dto.TableRequestDto")} tableRequestDto,  Boolean startsWith){
		return this.${nombreDao}.getMultiple(filter${pojo.getDeclarationName()}, tableRequestDto, startsWith);
	}
      
	
	<#foreach property in pojo.getAllPropertiesIterator()>
		<#if pojo.getMetaAttribAsBool(property, "gen-property", true)>
			<#if c2h.isManyToMany(property)>
				<#if c2h.isCollection(property)>
					<#include "serviceRelationsImpl.ftl"/>
				</#if> 								
			</#if>
		</#if>
	</#foreach>
	
<#if annot==0>   
	/**
	 * Setter method for ${pojo.beanCapitalize(nombreDao)}.
	 *
	 * @param  ${nombreDao} ${pojo.importType(pojo.getPackageName()+'.dao.'+pojo.getDeclarationName()+'Dao')}
	 * @return
	 */
	public void set${pojo.beanCapitalize(nombreDao)}(${pojo.importType(pojo.getPackageName()+'.dao.'+pojo.getDeclarationName()+'Dao')} ${nombreDao}) {
		${pojo.getDeclarationName()}ServiceImpl.logger.info("Setting Dependency "+${nombreDao});
		this.${nombreDao} = ${nombreDao};
	}
</#if>
}
</#assign>
${pojo.generateImports()}
${classbody}
