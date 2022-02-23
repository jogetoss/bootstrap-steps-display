<link rel="stylesheet" href="${request.contextPath}/plugin/org.joget.marketplace.BootstrapStepsDisplayField/css/stepsIconFormatter.css">
<link rel="stylesheet" href="${request.contextPath}/plugin/org.joget.marketplace.BootstrapStepsDisplayField/css/pe-icon-7-stroke.min.css">

<style type="text/css">

    td.column_${columnName!} .stepsIcon{
        
    }

    td.column_${columnName!} .stepsIcon .step .step-title{
        font-size: 14px;
    }

    td.column_${columnName!} .stepsIcon .step .step-icon {
        background-color: ${element.properties.iconBackgroundColor!};
    }

    td.column_${columnName!} .step-icon i{
        color: ${element.properties.iconColor!};
        font-size: 28px !important;
        vertical-align: middle;
    }

    td.column_${columnName!} .stepsIcon .step.completed .step-icon-wrap::before,
    td.column_${columnName!} .stepsIcon .step.completed .step-icon-wrap::after {
        background-color: ${element.properties.iconBackgroundColor!};
    }

    td.column_${columnName!} .stepsIcon .step.completed .step-icon {
        border-color: ${element.properties.iconBackgroundColorComplete!};
        background-color: ${element.properties.iconBackgroundColorComplete!};
        color: ${element.properties.iconColor!};
    }

</style>