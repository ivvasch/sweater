<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="mb-3">
            <label for="exampleInputUserName" class="form-label">User Name</label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control" placeholder="User name"/>
            </div>
        </div>

        <div class="mb-3">
            <label for="exampleInputPassword" class="form-label">Password</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" id="exampleInputPassword"
                       placeholder="Password"/></div>
        </div>
        <#if isRegisterForm>
            <div class="mb-3">
                <label for="exampleInputEmail" class="form-label">E-mail</label>
                <div class="col-sm-6">
                    <input type="email" name="email" class="form-control" id="exampleInputEmail"
                           placeholder="some@some.com"/></div>
            </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary"><#if isRegisterForm>Create<#else>Sign In</#if></button>
        <div><#if !isRegisterForm><a href="/registration">Add new User</a></#if></div>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Sign Out"</button>
    </form>
</#macro>