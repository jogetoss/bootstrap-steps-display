package org.joget.marketplace;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import org.joget.apps.app.service.AppService;
import org.joget.apps.app.service.AppUtil;
import org.joget.apps.form.model.FormBuilderPaletteElement;
import org.joget.apps.form.model.FormData;
import org.joget.apps.form.model.FormRow;
import org.joget.apps.form.model.FormRowSet;
import org.joget.apps.form.service.FormUtil;
import org.joget.apps.form.dao.FormDataDao;
import org.joget.apps.form.model.Element;
import org.joget.apps.form.model.Form;

public class BootstrapStepsDisplayField extends Element implements FormBuilderPaletteElement {

    @Override
    public String getName() {
        return "Bootstrap Steps Display Field";
    }

    @Override
    public String getVersion() {
        return Activator.VERSION;
    }

    @Override
    public String getDescription() {
        return "Bootstrap Steps Display Field";
    }

    public Collection<Map> getOptionMap(FormData formData) {
        Collection<Map> optionMap = FormUtil.getElementPropertyOptionsMap(this, formData);
        return optionMap;
    }
    
    @Override
    public String renderTemplate(FormData formData, Map dataModel) {
        String theme = (String)getProperty("theme");
        String template = "";

        if(theme.equalsIgnoreCase("1")){
            template = "BootstrapStepsDisplayField.ftl";
        }else if(theme.equalsIgnoreCase("2")){
            template = "BootstrapStepsDisplayFieldIcon.ftl";
        }
        
        //set scale
        String scale = (String)getProperty("scale");
        if(scale == null){
            if(theme.equalsIgnoreCase("1")){
                scale = "1.5";
            }else if(theme.equalsIgnoreCase("2")){
                scale = "1";
            }
        }
        dataModel.put("scale", scale);
        
        // set options
        Collection<Map> optionMap = new ArrayList<>();
        String datasource = (String) getProperty("datasource");

        if (datasource != null){
            if (datasource.equals("manual")){
                optionMap = getOptionMap(formData);
                dataModel.put("options", optionMap);
            } else if(datasource.equals("formdata")){
                String formDefId = (String) getProperty("formDefId");
                String numberingField = (String) getProperty("numbering");
                String iconField = (String) getProperty("icon");
                String valueField = (String) getProperty("value");
                String labelField = (String) getProperty("labelvalue");
            
                AppService appService = (AppService) AppUtil.getApplicationContext().getBean("appService");
                FormDataDao formDataDao = (FormDataDao) AppUtil.getApplicationContext().getBean("formDataDao");
                String tableName = appService.getFormTableName(AppUtil.getCurrentAppDefinition(), formDefId);
                FormRowSet data = formDataDao.find(formDefId, tableName, null, null, null, null, null, null);
    
                for (FormRow r : data) {
                    String numberingStr = r.getProperty(numberingField);
                    String iconStr = r.getProperty(iconField);
                    String valueStr = r.getProperty(valueField);
                    String labelStr = r.getProperty(labelField);
    
                    FormRow fr = new FormRow();
                    fr.setProperty("numbering", numberingStr);
                    fr.setProperty("icon", iconStr);
                    fr.setProperty("value", valueStr);
                    fr.setProperty("label", labelStr);
    
                    optionMap.add(fr);
                }
            
                // sort by numbering
                List<Map> sortedOptionMap = new ArrayList<>(optionMap);
                
                Collections.sort(sortedOptionMap, (map1, map2) -> {
                    String numbering1 = (String) map1.get("numbering");
                    String numbering2 = (String) map2.get("numbering");
                    return numbering1.compareTo(numbering2); // For string-based sorting
                });
                dataModel.put("options", sortedOptionMap);
            }
        } else {
            dataModel.put("options", optionMap);
        }
        
        Form form = FormUtil.findRootForm(this);
        
        Element statusElement = FormUtil.findElement(getPropertyString("statusFieldId"), form, formData);
        if (statusElement != null) {
            String statusValue = FormUtil.getElementPropertyValue(statusElement, formData);
            dataModel.put("value", statusValue);
        }

        String html = FormUtil.generateElementHtml(this, formData, template, dataModel);
        return html;
    }
    
//    public FormRowSet formatData(FormData formData) {
//        FormRowSet rowSet = null;
//
//        // get value
//        String id = getPropertyString(FormUtil.PROPERTY_ID);
//        if (id != null) {
//            String value = FormUtil.getElementPropertyValue(this, formData);
//            if (value != null) {
//                // set value into Properties and FormRowSet object
//                FormRow result = new FormRow();
//                result.setProperty(id, value);
//                rowSet = new FormRowSet();
//                rowSet.add(result);
//            }
//        }
//
//        return rowSet;
//    }


    @Override
    public String getClassName() {
        return getClass().getName();
    }

    @Override
    public String getFormBuilderTemplate() {
        return "<label class='label'>Steps Display</label>";
    }

    @Override
    public String getLabel() {
        return "Steps Display";
    }

    @Override
    public String getPropertyOptions() {
        return AppUtil.readPluginResource(getClass().getName(), "/properties/form/BootstrapStepsDisplayField.json", null, true, "messages/form/BootstrapStepsDisplayField");
    }

    @Override
    public String getFormBuilderCategory() {
        return "Marketplace";
    }

    @Override
    public int getFormBuilderPosition() {
        return 500;
    }

    @Override
    public String getFormBuilderIcon() {
        return "<i class=\"fas fa-info\"></i>";
    }

}
