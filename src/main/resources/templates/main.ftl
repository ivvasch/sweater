<#import "parts/common.ftl" as c>

<@c.page>
    <form method="get" action="main">
        <label class="form-control">
            <input class="mb-3" type="text" name="filter" value="${filter?ifExists}" placeholder="Search by tag">
            <button type="submit" class="btn btn-primary">Search</button>
        </label>
    </form>
    <a class="btn btn-primary mb-3" data-bs-toggle="collapse" href="#collapseExample" role="button"
       aria-expanded="false"
       aria-controls="collapseExample">
        Add new message
    </a>
    <div class="collapse" id="collapseExample">
        <form method="post" enctype="multipart/form-data">
            <label class="mb-3">
                <label class="form-control">
                    <input type="text" name="text" placeholder="Введите сообщение"/>
                    <input type="text" name="tag" placeholder="Тэг"/>
                </label>
                <div>
                    <label for="formFile" class="form-label mb-3">Default file input example</label>
                    <input class="form-control" type="file" name="file" id="formFile">
                </div>
            </label>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>
            <button type="submit" class="btn btn-primary mg-3">Добавить</button>
        </form>
    </div>
    <div class="row row-cols-1 row-cols-md-5 g-4">
    <#list messages as message>
            <div class="col">
                <div class="card my-3">
                    <#if message.filename??>
                        <img src="/img/${message.filename}" class="card-img-top">
                    </#if>
                    <div class="m-2">
                        <span>${message.text}</span>
                        <i>${message.tag}</i>
                    </div>
                    <div class="card-footer text-muted">
                        ${message.userName}
                    </div>
                </div>
            </div>
    <#else>
        No messages
    </#list>
    </div>
</@c.page>
