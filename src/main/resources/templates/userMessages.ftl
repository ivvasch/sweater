<#import "parts/common.ftl" as c>

<@c.page>
    <#if !isCurrentUser>
        <#if isSubscriber??>
            <a class="btn btn-danger" href="/user/unsubscribe/${userChanel.id}">UnSubscribe</a>
        <#else>
            <a class="btn btn-info" href="/user/subscribe/${userChanel.id}">Subscribe</a>
        </#if>
    </#if>
    <h3>${userChanel.username}</h3>
    <div class="container my-3">
        <div class="row my-1">
            <div class="col">
                <div class="card">
                <div class="card-body">
                    <div class="card-title">Subscriptions</div>
                    <h3 class="card-text"><a href="/user/subscriptions/${userChanel.id}/list">${subscriptionCount}</a></h3>
                </div>
            </div>
        </div>
        <div class="row my-1">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <div class="card-title">Subscribers</div>
                        <h3 class="card-text"><a href="/user/subscribers/${userChanel.id}/list">${subscribersCount}</a></h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <#if isCurrentUser>
        <#include "parts/messageEdit.ftl" />
    </#if>
    <#include "parts/messageList.ftl"/>
</@c.page>