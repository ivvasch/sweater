<#macro pager url page>
    <#if page.getTotalPages() gt 7>
        <#assign
            totalPages = page.getTotalPages()
            pageNumber = page.getNumber() + 1
            head = (pageNumber > 4)?then([1, -1], [1,2,3])
            tail = (pageNumber < totalPages - 3)?then([-1, totalPages], [totalPages - 2, totalPages - 1, totalPages])
            bodyBefore = (pageNumber > 4 && pageNumber < totalPages - 1)?then([pageNumber - 2, pageNumber - 1], [])
            bodyAfter = (pageNumber > 2 && pageNumber < totalPages - 3)?then([pageNumber + 1, pageNumber + 2], [])

            body = head + bodyBefore + (pageNumber > 3 && pageNumber > totalPages - 2)?then([pageNumber], []) + bodyAfter + tail
        >
        <#else>
        <#assign body = 1..page.getTotalPages()>
    </#if>
    <div>
        <ul class="pagination">
            <#if page.hasPrevious()>
            <li class="page-item"><a class="page-link" href="${url}?page=${page.getNumber() - 1}&size=${page.getSize()}">Previous</a></li>
            <#else>
                <li class="page-item disabled"><a class="page-link" href="#">Previous</a></li>
            </#if>
            <#list body as p>
                <#if (p - 1) == page.getNumber()>
            <li class="page-item active" ><a class="page-link" href="#" tabindex="-1">${p}</a></li>
            <#elseif p == -1>
                <li class="page-item disabled" ><a class="page-link" href="#" tabindex="-1">...</a></li>
                <#else>
            <li class="page-item"><a class="page-link" methods="get" href="${url}?page=${p - 1}&size=${page.getSize()}" tabindex="-1">${p}</a></li>
                </#if>
            </#list>
            <#if page.getNumber() lt (page.getTotalPages() - 1)>
            <li class="page-item"><a class="page-link" href="${url}?page=${page.getNumber() + 1}&size=${page.getSize()}">Next</a></li>
                <#else>
                    <li class="page-item disabled"><a class="page-link" href="#">Next</a></li>
            </#if>
        </ul>

        <ul class="pagination">
            <li class="page-item disabled"><a class="page-link" href="#">All elements</a></li>
            <#list [2, 5, 10, 15, 20] as s>
                <#if s == page.getSize()>
                    <li class="page-item disabled" ><a class="page-link" href="#" tabindex="-1">${s}</a></li>
                <#else>
                    <li class="page-item" >
                        <a class="page-link" methods="get" href="${url}?page=${page.getNumber()}&size=${s}" tabindex="-1">${s}</a></li>
                </#if>
            </#list>
        </ul>
    </div>
</#macro>