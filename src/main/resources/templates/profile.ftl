<#import "parts/common.ftl" as c>
<@c.page>
    <h5>${username}</h5>
    ${message?ifExists}
    <form method="post">
        <div class="mb-3">
            <label for="exampleInputPassword" class="form-label">Password</label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" id="exampleInputPassword"
                       placeholder="Password"/></div>
        </div>
            <div class="mb-3">
                <label for="exampleInputEmail" class="form-label">E-mail</label>
                <div class="col-sm-6">
                    <input type="email" name="email" class="form-control" id="exampleInputEmail"
                           placeholder="some@some.com" value="${email!""}"/></div>
            </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-primary">Save</button>
    </form>

</@c.page>