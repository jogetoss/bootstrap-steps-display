<div class="form-cell" ${elementMetaData!}>
    <link rel="stylesheet" href="${request.contextPath}/plugin/org.joget.marketplace.BootstrapStepsDisplayField/css/bootstrap-steps.min.css">
    <style type="text/css">
        #${elementParamName!}.steps {
            transform: scale(1.5);
            margin: 1.2rem auto;
            width: fit-content;
            width: -moz-fit-content;
        }

        #${elementParamName!} .step-circle {
            width: 2.5rem;
            height: 2.5rem;
        }

        #${elementParamName!} .step-circle::before{
            width: calc(8rem + 1rem - 2.5rem);
        }

        #${elementParamName!} .step-content{
            width: 8rem;
            max-width: 8rem;
        }

        #${elementParamName!} .step-text{
            word-break: break-word;
            text-align: center;
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

            $("#${elementParamName!}").find("li.step").removeClass("step-active").removeClass("step-success");
            if( value != ""){
                $("#${elementParamName!}").find(".step[attr-data='" + value + "']").addClass("step-active");
                $("#${elementParamName!}").find(".step[attr-data='" + value + "']").prevAll().addClass("step-success");
            }
        }

    </script>
    
       <ul id="${elementParamName!}" class="steps">
            <#list options as option>
                <li attr-data="${option.value!?html}" class="step">
                  <div class="step-content">
                    <span class="step-circle">${option.numbering!?html}</span>
                    <span class="step-text">${option.label!?html}</span>
                  </div>
                </li>
            </#list>
      </ul>

</div>