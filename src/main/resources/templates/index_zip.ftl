<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <title>代码生成平台</title>
    <link rel="icon" type="image/x-icon" href="/static/favicon.ico">
    <#import "common/common.macro.ftl" as netCommon>
    <@netCommon.commonStyle />
    <link rel="stylesheet" href="${request.contextPath}/static/plugins/codemirror/lib/codemirror.css">
    <link rel="stylesheet" href="${request.contextPath}/static/plugins/codemirror/addon/hint/show-hint.css">

</head>
<body class="hold-transition skin-blue layout-top-nav ">
<div class="wrapper">

<#-- header -->
<@netCommon.commonHeader />


    <#-- content -->
    <div class="content-wrapper">
        <div class="container">

            <section class="content">

                <div class="row">

                    <#-- left -->
                    <div class2="col-md-9" >

                        <#-- 表结构 -->
                        <div class="box box-default">
                            <div class="box-header with-border">
                                <h4 class="pull-left">表结构信息</h4>
                                <button type="button" class="btn btn-default btn-xs pull-right" id="codeGenerate_zip" >生成springboot2.0工程</button>
                            </div>
                            <div class="box-body">
                                <ul class="chart-legend clearfix">
                                    <li>
                                        <small class="text-muted" >
                                            <textarea id="tableSql" placeholder="请输入表结构信息..." >
CREATE TABLE `userinfo` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `addtime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息';
CREATE TABLE `userinfo2` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `addtime` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户信息';

                                            </textarea>
                                        </small>
                                    </li>
                                </ul>
                            </div>
                        </div>

                            <div class="row">

                                <div class="col-xs-3">
                                    <h5 class="pull-left">groupId ： </h5>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="groupId" autocomplete="on" placeholder="com.test"  value="com.test">
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <h5 class="pull-left">artifactId ： </h5>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="artifactId" autocomplete="on" placeholder="accident" value="accident" >
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <h5 class="pull-left">项目描述 ： </h5>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="description" autocomplete="on" placeholder="爱心意外险平台" value="爱心意外险平台" >
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <h5 class="pull-left">springboot版本 ： </h5>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="springbootversion" autocomplete="on" placeholder="2.1.6.RELEASE"  value="2.1.6.RELEASE">
                                    </div>
                                </div>
                            </div>

                    </div>

                </div>

        </section>


    </div>
</div>

<!-- footer -->
<@netCommon.commonFooter />

</div>

<@netCommon.commonScript />
<script src="${request.contextPath}/static/plugins/codemirror/lib/codemirror.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/addon/hint/show-hint.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/addon/hint/anyword-hint.js"></script>

<script src="${request.contextPath}/static/plugins/codemirror/addon/display/placeholder.js"></script>

<script src="${request.contextPath}/static/plugins/codemirror/mode/clike/clike.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/mode/sql/sql.js"></script>
<script src="${request.contextPath}/static/plugins/codemirror/mode/xml/xml.js"></script>

<script src="${request.contextPath}/static/js/index_zip.js"></script>

</body>
</html>
