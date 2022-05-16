<#import "parts/common.ftl" as c>

<@c.page>
    <form method="get" action="main">
        <label class="form-control">
            <div class="form-group">
                <label class="mb-3">
                    <input class="form-control mb-3" type="text" name="filter" value="${filter?ifExists}"
                           placeholder="Search by tag">
                    <button type="submit" class="btn btn-primary">Search</button>
                </label>
            </div>
        </label>
    </form><p></p>
    <#include "parts/messageEdit.ftl" />
<#include "parts/messageList.ftl"/>
</@c.page>
