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
package ${pojo.getPackageName()}.dao;
<#assign classbody>
<#assign props = pojo.getAllPropertiesIterator()>
<#assign declarationName = pojo.importType(pojo.getDeclarationName()) >
<#-- calculamos los campos para luego no tener que estar recorrer el array -->
 <#assign camposPropiedades = pojo.getAllPropertiesIterator()> 
  <#assign camposPropiedadesOtros = clazz.getPropertyIterator()>
import ${pojo.importType(pojo.getPackageName()+'.model.'+pojo.getDeclarationName())};

/**
 * ${pojo.getClassJavaDoc(pojo.getDeclarationName() + "DaoImpl generated by UDA", 0)}, ${date}.
 * @author UDA
 */
 
<#if annot!=0>@${pojo.importType("org.springframework.stereotype.Repository")}</#if>
@${pojo.importType("org.springframework.transaction.annotation.Transactional")}
public class ${pojo.getDeclarationName()}DaoImpl implements ${pojo.getDeclarationName()}Dao {
    private ${pojo.importType("org.springframework.jdbc.core.simple.SimpleJdbcTemplate")} jdbcTemplate;
	private ${pojo.importType("org.springframework.jdbc.core.RowMapper")}<${pojo.getDeclarationName()}> rwMap = new ${pojo.importType("org.springframework.jdbc.core.RowMapper")}<${pojo.getDeclarationName()}>() {
		public ${pojo.getDeclarationName()} mapRow(${pojo.importType("java.sql.ResultSet")} resultSet, int rowNum) throws ${pojo.importType("java.sql.SQLException")} {
           return new ${pojo.getDeclarationName()}(
               ${utilidadesDao.rowmapperUpdate(pojo,cfg)}
           ); } } ;

	/**
     * Method use to set the datasource.
     *
     * @param dataSource ${pojo.importType("javax.sql.DataSource")}
     * @return
     */
    <#if annot!=0>@${pojo.importType("javax.annotation.Resource")}</#if>
    public void setDataSource(${pojo.importType("javax.sql.DataSource")} dataSource) {
    	this.jdbcTemplate = new ${pojo.importType("org.springframework.jdbc.core.simple.SimpleJdbcTemplate")}(dataSource);
    }

    /**
     * Inserts a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.importType("com.ejie.x38.dto.Pagination")}
     * @return ${pojo.getDeclarationName()}
     */
	public ${pojo.getDeclarationName()} add(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}) {

		<#assign  parametros =utilidadesDao.getInsertFields(pojo,cfg)>
    	<#assign interrogaciones = parametros >
    	String query = "INSERT INTO ${ctrTl.findDataBaseName(pojo.getDeclarationName())?upper_case}( <#list parametros as param>${param}<#if param_has_next>,</#if></#list>)"
        + "VALUES (<#list interrogaciones as param>?<#if param_has_next>,</#if></#list>)";

		<#assign  valoresInsert =utilidadesDao.getInsertValues(pojo,cfg)>	
		<#assign nulablesFields= valoresInsert>
		<#list nulablesFields as ifsValoRes>
			<#if ifsValoRes[1]!= '0'>
				   Object ${ifsValoRes[4]}Aux=null;
		     if (${ifsValoRes[2]}!= null <#if ifsValoRes[3]!=''> && ${ifsValoRes[3]}</#if> && ${ifsValoRes[0]}!=null ){
			     ${ifsValoRes[4]}Aux=${ifsValoRes[0]};
		   	  }
		   </#if>
		</#list>
		this.jdbcTemplate.update(query, <#list valoresInsert as param><#if param[1]!= '0'>${param[4]}Aux<#else>${param[0]}</#if><#if param_has_next>, </#if></#list>);
		return ${pojo.getDeclarationName()?lower_case};
	}

    /**
     * Updates a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.importType("com.ejie.x38.dto.Pagination")}
     * @return ${pojo.getDeclarationName()}
     */
    public ${pojo.getDeclarationName()} update(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}) {
    	<#assign  paramSetter =utilidadesDao.getUpdateFields(pojo,cfg)>
		<#assign  paramWhere =utilidadesDao.getWherePk(pojo,cfg)>
		String query = "UPDATE ${ctrTl.findDataBaseName(pojo.getDeclarationName())?upper_case} SET <#list paramSetter as param>${param}=?<#if param_has_next>,</#if></#list> WHERE <#list paramWhere as param>${param}=?<#if param_has_next> AND </#if></#list>";
		<#assign  paramUpdate =utilidadesDao.camposQueryUpdate(pojo,cfg)>
		<#assign nulablesFieldsUpdate= paramUpdate>
		<#list nulablesFieldsUpdate as ifsValoRes>
			<#if ifsValoRes[1]!= '0'>
				Object ${ifsValoRes[4]}Aux=null;
				if (${ifsValoRes[2]}!= null <#if ifsValoRes[3]!=''> && ${ifsValoRes[3]}</#if>  && ${ifsValoRes[0]}!=null ){
					${ifsValoRes[4]}Aux=${ifsValoRes[0]};
				}
			</#if>
		</#list>
		this.jdbcTemplate.update(query, <#list paramUpdate as param><#if param[1]!= '0'>${param[4]}Aux<#else>${param[0]}</#if><#if param_has_next>, </#if></#list>);
		return ${pojo.getDeclarationName()?lower_case};
	}

    /**
     * Finds a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.importType("com.ejie.x38.dto.Pagination")}
     * @return ${pojo.getDeclarationName()}
     */
    @${pojo.importType("org.springframework.transaction.annotation.Transactional")} (readOnly = true)
    public ${pojo.getDeclarationName()} find(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}) {
		<#assign  paramSelectFind =utilidadesDao.camposSelectFind(pojo,cfg)>
		<#assign  paramTablaSelect =utilidadesDao.tablasSelect(pojo,cfg)>
		<#assign  paramWhereFields =utilidadesDao.whereFindPK(pojo,cfg)>
		<#assign  paramPk =utilidadesDao.commaPrimary(pojo,cfg)>
		String query = "SELECT <#list paramSelectFind as param>${param}<#if param_has_next>, </#if></#list> " 
         + "FROM <#list paramTablaSelect as param>${param}<#if param_has_next>, </#if></#list> " 
         + "WHERE <#list paramWhereFields as param>${param}<#if param_has_next> AND </#if></#list>  ";
		return (${pojo.getDeclarationName()}) this.jdbcTemplate.queryForObject(query, 
			rwMap , <#list paramPk as param>${param}<#if param_has_next> , </#if></#list>);	 
      	<#--return (${pojo.getDeclarationName()}) this.jdbcTemplate.queryForObject(query, 
        new ${pojo.importType("org.springframework.jdbc.core.RowMapper")}<${pojo.getDeclarationName()}>() {
          public ${pojo.getDeclarationName()} mapRow(${pojo.importType("java.sql.ResultSet")} resultSet, int rowNum) throws ${pojo.importType("java.sql.SQLException")} {
           return new ${pojo.getDeclarationName()}(
               ${utilidadesDao.rowmapperUpdate(pojo,cfg)}
           ); } } , <#list paramPk as param>${param}<#if param_has_next> , </#if></#list>);-->
    }

    /**
     * Removes a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.importType("com.ejie.x38.dto.Pagination")}
     * @return
     */
    public void remove(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}) {
		<#assign  paramPkRemove =paramPk>
		<#assign  paramWhereRemove =paramWhere>
		String query = "DELETE  FROM ${ctrTl.findDataBaseName(pojo.getDeclarationName())?upper_case} WHERE <#list paramWhereRemove as param>${param}=?<#if param_has_next> AND </#if></#list>";
		this.jdbcTemplate.update(query, <#list paramPkRemove as param>${param}<#if param_has_next> , </#if></#list>);
    	}
    
    <#include "findAllDinamycImpl.ftl"/>
    <#foreach property in pojo.getAllPropertiesIterator()>
      <#if c2h.isManyToMany(property)>
        <#if c2h.isCollection(property)>
           <#include "daoRelationsImpl.ftl"/>					
        </#if>
      </#if>
    </#foreach>
}
</#assign>

${pojo.generateImports()}
${classbody}
