$(function () {



    var localstorageppname = localStorage.getItem('ppname');
    if(localstorageppname){
        $("#ppname").val(localstorageppname);
    }


    /**
     * 初始化 table sql
     */
    var tableSqlIDE;
    function initTableSql() {
        tableSqlIDE = CodeMirror.fromTextArea(document.getElementById("tableSql"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-sql",
            lineWrapping:false,
            readOnly:false,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        tableSqlIDE.setSize('auto','auto');
    }
    initTableSql();

    /**
     * 初始化 code area
     */

    var controller_ide;
    var service_ide;
    var vo_ide;
    var dto_ide;
    var dao_ide;
    var mybatis_ide;
    var model_ide;
    function initCodeArea(){

        // controller_ide
        controller_ide = CodeMirror.fromTextArea(document.getElementById("controller_ide"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-java",
            lineWrapping:true,
            readOnly:true,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        controller_ide.setSize('auto','auto');

        // service_ide
        service_ide = CodeMirror.fromTextArea(document.getElementById("service_ide"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-java",
            lineWrapping:true,
            readOnly:true,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        service_ide.setSize('auto','auto');

        // vo_ide
        vo_ide = CodeMirror.fromTextArea(document.getElementById("vo_ide"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-java",
            lineWrapping:true,
            readOnly:true,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        vo_ide.setSize('auto','auto');

        // dto_ide
        dto_ide = CodeMirror.fromTextArea(document.getElementById("dto_ide"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-java",
            lineWrapping:true,
            readOnly:true,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        dto_ide.setSize('auto','auto');


        // dao_ide
        dao_ide = CodeMirror.fromTextArea(document.getElementById("dao_ide"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-java",
            lineWrapping:true,
            readOnly:true,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        dao_ide.setSize('auto','auto');

        // mybatis_ide
        mybatis_ide = CodeMirror.fromTextArea(document.getElementById("mybatis_ide"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/html",
            lineWrapping:true,
            readOnly:true
        });
        mybatis_ide.setSize('auto','auto');

        // model_ide
        model_ide = CodeMirror.fromTextArea(document.getElementById("model_ide"), {
            lineNumbers: true,
            matchBrackets: true,
            mode: "text/x-java",
            lineWrapping:true,
            readOnly:true,
            foldGutter: true,
            gutters:["CodeMirror-linenumbers", "CodeMirror-foldgutter"]
        });
        model_ide.setSize('auto','auto');
    }

    initCodeArea();

    /**
     * 生成代码
     */
    $('#codeGenerate').click(function () {
        var ppname = $("#ppname").val();
        if(ppname){
            localStorage.setItem('ppname',ppname);
        }
        var tableSql = tableSqlIDE.getValue();

        $.ajax({
            type : 'POST',
            url : base_url + "/codeGenerate",
            data : {
                "tableSql" : tableSql,
                "ppname":ppname
            },
            dataType : "json",
            success : function(data){
                if (data.code == 200) {
                    layer.open({
                        icon: '1',
                        content: "代码生成成功" ,
                        end: function(layero, index){

                            controller_ide.setValue(data.data.controller_code);
                            controller_ide.setSize('auto','auto');

                            service_ide.setValue(data.data.service_code);
                            service_ide.setSize('auto','auto');

                            vo_ide.setValue(data.data.vo_code);
                            vo_ide.setSize('auto','auto');

                            dto_ide.setValue(data.data.dto_code);
                            dto_ide.setSize('auto','auto');

                            dao_ide.setValue(data.data.dao_code);
                            dao_ide.setSize('auto','auto');

                            mybatis_ide.setValue(data.data.mybatis_code);
                            mybatis_ide.setSize('auto','auto');

                            model_ide.setValue(data.data.model_code);
                            model_ide.setSize('auto','auto');

                        }
                    });
                } else {
                    layer.open({
                        icon: '2',
                        content: (data.msg||'代码生成失败')
                    });
                }
            }
        });

    });

    /**
     * 生成代码
     */
    $('#codeGenerate-swagger').click(function () {

        var ppname = $("#ppname").val();
        if(ppname){
            localStorage.setItem('ppname',ppname);
        }
        var tableSql = tableSqlIDE.getValue();

        $.ajax({
            type : 'POST',
            url : base_url + "/codeGenerate-swagger",
            data : {
                "tableSql" : tableSql,
                "ppname": ppname
            },
            dataType : "json",
            success : function(data){
                if (data.code == 200) {
                    layer.open({
                        icon: '1',
                        content: "代码生成成功" ,
                        end: function(layero, index){

                            controller_ide.setValue(data.data.controller_code);
                            controller_ide.setSize('auto','auto');

                            service_ide.setValue(data.data.service_code);
                            service_ide.setSize('auto','auto');

                            vo_ide.setValue(data.data.vo_code);
                            vo_ide.setSize('auto','auto');

                            dto_ide.setValue(data.data.dto_code);
                            dto_ide.setSize('auto','auto');

                            dao_ide.setValue(data.data.dao_code);
                            dao_ide.setSize('auto','auto');

                            mybatis_ide.setValue(data.data.mybatis_code);
                            mybatis_ide.setSize('auto','auto');

                            model_ide.setValue(data.data.model_code);
                            model_ide.setSize('auto','auto');

                        }
                    });
                } else {
                    layer.open({
                        icon: '2',
                        content: (data.msg||'代码生成失败')
                    });
                }
            }
        });

    });

    $('#codeGenerate_swagger_zip').click(function () {
        var ppname = $("#ppname").val();
        if(ppname){
            localStorage.setItem('ppname',ppname);
        }
        var tableSql = tableSqlIDE.getValue();

        $.ajax({
            type : 'POST',
            url : base_url + "/codeGenerate_swagger_zip",
            data : {
                "tableSql" : tableSql,
                "ppname" : ppname

            },
            dataType : "json",
            success : function(data){
                if (data.code == 200) {
                    location.href = base_url +"/downloadzip?name=" +data.data;
                } else {
                    alert(data)
                }
            }
        });

    });

});