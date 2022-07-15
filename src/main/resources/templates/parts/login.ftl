<#macro login path isRegisterForm>
    <form action="${path}" method="post" xmlns="http://www.w3.org/1999/html" xmlns="http://www.w3.org/1999/html">
        <div class="mb-3">
            <label for="exampleInputUserName">User Name</label>
            <div class="col-sm-6">
                <input type="text" name="username" value="<#if user??>${user.username}</#if>"
                       class="form-control  ${(usernameError??)?string('is-invalid', '')}" placeholder="User name"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
            <label for="exampleInputPassword">Password</label>
            <div class="col-sm-6">
                <input type="password" name="password"
                       class="form-control ${(passwordError??)?string('is-invalid', '')}"
                       id="exampleInputPassword" placeholder="Password"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="mb-3"></div>
            <label for="exampleInputPassword">Password</label>
            <div class="col-sm-6">
                <input type="password" name="password2"
                       class="form-control ${(password2Error??)?string('is-invalid', '')}"
                       id="exampleInputPassword" placeholder="Retype password"/>
                <#if password2Error??>
                    <div class="invalid-feedback">
                        ${password2Error}
                    </div>
                </#if>
            </div>
            <div class="mb-3"></div>
            <label for="exampleInputEmail">E-mail</label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control ${(emailError??)?string('is-invalid', '')}"
                       id="exampleInputEmail" value="<#if user??>${user.email}</#if>" placeholder="some@some.com"/>
                <#if emailError??>
                    <div class="invalid-feedback mb-3">
                        ${emailError}
                    </div>
                </#if>
            </div>
            <div><p></p>
                <div class="g-recaptcha" data-sitekey="6LdWJRUfAAAAAASnBVbBULHz3nvYmeP0keBEQhgP"></div>
                <#if captchaError??>
                    <div class="form-group p-3 mb-2 bg-danger text-white">
                        ${captchaError}
                    </div>
                </#if>
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
        <button type="submit" class="btn btn-primary"><#if user??>Log Out<#else>Log In</#if></button>
    </form>
</#macro>