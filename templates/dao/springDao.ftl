package ${pojo.getPackageName()}.dao;
/**
${pojo.getClassJavaDoc(pojo.getDeclarationName() + " generated by UDA 1.0", 0)}, ${date}.
 */

<#assign classbody>
<#assign declarationName = pojo.importType(pojo.getDeclarationName()) >
import ${pojo.importType(pojo.getPackageName()+'.model.'+pojo.getDeclarationName())};
<#-- calculamos los campos para luego no tener que estar recorrer el array -->
/**
${pojo.getClassJavaDoc(pojo.getDeclarationName() + "Dao generated by UDA 1.0", 0)}, ${date}.
* @author UDA
*/
public interface ${pojo.getDeclarationName()}Dao {
    /**
     * Inserts a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
     * @return ${pojo.getDeclarationName()}
     */
    ${pojo.getDeclarationName()} add(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case});

    /**
     * Updates a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
     * @return ${pojo.getDeclarationName()}
     */
    ${pojo.getDeclarationName()} update(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case});

    /**
     * Finds a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
     * @return ${pojo.getDeclarationName()}
     */
    ${pojo.getDeclarationName()} find(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case});

    /**
     * Deletes a single row in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
     * 
     */
    void remove(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case});

    /**
     * Finds a List of rows in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
     * @param pagination ${pojo.importType("com.ejie.x38.dto.Pagination")}
     * @return ${pojo.importType("java.util.List")}
     */
    ${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAll(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}, ${pojo.importType("com.ejie.x38.dto.Pagination")} pagination);

    /**
     * Counts rows in the ${pojo.getDeclarationName()} table.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
     * @return ${pojo.importType("java.util.List")}
     */
    Long findAllCount(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case});
	 /**
     * Finds rows in the ${pojo.getDeclarationName()} table using like.
     *
     * @param ${pojo.getDeclarationName()?lower_case} ${pojo.getDeclarationName()}
     * @return ${pojo.importType("java.util.List")}
     */
	${pojo.importType("java.util.List")}<${pojo.getDeclarationName()}> findAllLike(${pojo.getDeclarationName()} ${pojo.getDeclarationName()?lower_case}, ${pojo.importType("com.ejie.x38.dto.Pagination")} pagination, Boolean startsWith);
     <#foreach property in pojo.getAllPropertiesIterator()>
       <#if pojo.getMetaAttribAsBool(property, "gen-property", true)>
         <#if c2h.isManyToMany(property)>
           <#if c2h.isCollection(property)>   
              <#include "springCRUDRelation.ftl"/>
          </#if> 								
         </#if>
       </#if>
      </#foreach>	
}
</#assign>
${pojo.generateImports()}
${classbody}
