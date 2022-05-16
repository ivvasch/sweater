<#include "security.ftl">
<label class="form-control">
    <div class="row row-cols-1 row-cols-md-5 g-4">
        <#list messages as message>
            <div class="col">
                <div class="card my-3">
                    <#if message.filename??>
                        <img src="/img/${message.filename}" class="card-img-top">
                    </#if>
                    <div class="m-2">
                        <span>${message.text}</span><br/>
                        <i>#${message.tag}</i>
                    </div>
                    <div class="card-footer text-muted">
                        <a href="/user-messages/${message.author.id}"> ${message.userName}</a>
                        <#if message.author.id == currentUserId>
                        <a class="btn btn-primary" href="/user-messages/${message.author.id}?message=${message.id}"> Edit</a>
                        </#if>
                    </div>
                </div>
            </div>
        <#else>
            No messages
        </#list>
    </div>
</label>