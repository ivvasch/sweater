<#import "parts/common.ftl" as c>
<#import "parts/login.ftl" as l>
<@c.page>
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION??>
            <div class="form-group p-3 mb-2 bg-danger text-white">
                ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
            </div>
    </#if>
    <#if messageType??>
        <div class="form-group p-3 mb-2 bg-${messageType} text-white">
            ${message}
        </div>
    </#if>
    <@l.login "/login" false/>
</@c.page>