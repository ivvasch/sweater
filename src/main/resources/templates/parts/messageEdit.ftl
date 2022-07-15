<label class="form-control">
    <a class="btn btn-primary mb-3" data-bs-toggle="collapse" href="#collapseExample" role="button"
       aria-expanded="false"
       aria-controls="collapseExample">
        Message Editor
    </a>
    <div class="collapse <#if message??> show</#if>" id="collapseExample">
        <form method="post" action="main" enctype="multipart/form-data">
            <#--                <label class="mb-3"> определяет размер блока на экране-->
            <div class="form-group">
                <input type="text" class="form-control ${(textError??)?string('is-invalid', '')}"
                       value="<#if message??>${message.text}</#if>" name="text"
                       placeholder="Введите сообщение"/>
                <#if textError??>
                    <div class="invalid-feedback">
                        ${textError}
                    </div>
                </#if>
            </div>
            <p></p>
            <div class="form-group">
                <input class="form-control ${(tagError??)?string('is-invalid', '')}"
                       value="<#if message??>${message.tag}</#if>"
                       type="text" name="tag" placeholder="Тэг"/>
                <#if tagError??>
                    <div class="invalid-feedback">
                        ${tagError}
                    </div>
                </#if>
            </div>
            <#--                </label>-->
            <div>
                <label for="formFile" class="form-label mb-3">Default file input example</label>
                <input class="form-control" type="file" name="file" id="formFile"/>
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <input type="hidden" name="id" value="<#if message??>${message.id}</#if>"/>
                <p></p>
                <button type="submit" class="btn btn-primary mg-3">Сохранить сообщение</button>
            </div>
        </form>
    </div>
</label><p></p>