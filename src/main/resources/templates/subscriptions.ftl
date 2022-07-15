<#import "parts/common.ftl" as c>

<@c.page>
    <h3>${userChanel.username}</h3>
    <div>${type}</div>
    <ul class="list-group">
        <#list users as user>
        <li class="list-group-item">
            <a href="/user-messages/${user.id}">${user.getUsername()}</a>
        </li>
        </#list>
</@c.page>