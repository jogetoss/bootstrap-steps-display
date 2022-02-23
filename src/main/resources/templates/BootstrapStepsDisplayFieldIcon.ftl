<div class="form-cell" ${elementMetaData!}>
    <link rel="stylesheet" href="${request.contextPath}/plugin/org.joget.marketplace.BootstrapStepsDisplayField/css/stepsIcon.css">
    <link rel="stylesheet" href="${request.contextPath}/plugin/org.joget.marketplace.BootstrapStepsDisplayField/css/pe-icon-7-stroke.min.css">

    <style type="text/css">
        #${elementParamName!} .stepsIcon .step .step-icon {
            background-color: ${element.properties.iconBackgroundColor!};
        }

        #${elementParamName!} .step-icon i{
            color: ${element.properties.iconColor!};
            font-size: 36px !important;
            vertical-align: middle;
        }

        #${elementParamName!} .stepsIcon .step.completed .step-icon-wrap::before,
        #${elementParamName!} .stepsIcon .step.completed .step-icon-wrap::after {
            background-color: ${element.properties.iconBackgroundColor!};
        }

        #${elementParamName!} .stepsIcon .step.completed .step-icon {
            border-color: ${element.properties.iconBackgroundColorComplete!};
            background-color: ${element.properties.iconBackgroundColorComplete!};
            color: ${element.properties.iconColor!};
        }
    </style>
    <script type="text/javascript">

        $(function(){

            if( FormUtil.getField("${element.properties.statusFieldId!}").size() ){
                updateSteps_${elementParamName!}( FormUtil.getValue("${element.properties.statusFieldId!}") );
            }else{
                updateSteps_${elementParamName!}( "${value!}" );
            }

            FormUtil.getField("${element.properties.statusFieldId!}").change(function(){
                updateSteps_${elementParamName!}( FormUtil.getValue("${element.properties.statusFieldId!}") );
            });

        });

        function updateSteps_${elementParamName!}(value){
            value = value.replace(/"/g, '\\"');
            value = value.replace(/'/g, "\\'");

            $("#${elementParamName!}").find(".step").removeClass("completed").removeClass("active");
            if( value != ""){
                //$("#${elementParamName!}").find(".step[attr-data='" + value + "']").addClass("active");
                $("#${elementParamName!}").find(".step[attr-data='" + value + "']").prevAll().addClass("completed");
                $("#${elementParamName!}").find(".step[attr-data='" + value + "']").addClass("completed");
            }
        }

    </script>
    
    <div id="${elementParamName!}" class="card-body">
        <div class="stepsIcon d-flex flex-wrap flex-sm-nowrap justify-content-between padding-top-2x padding-bottom-1x">
            <#list options as option>
                <div attr-data="${option.value!?html}" class="step">
                    <div class="step-icon-wrap">
                        <div class="step-icon"><i class="${option.icon!?html}"></i></div>
                    </div>
                    <h4 class="step-title">${option.label!?html}</h4>
                </div>
            </#list>
        </div>
    </div>
</div>