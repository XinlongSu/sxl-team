# sxl-team
function msg(content) {
    $('.mini.modal .description').html(content)
    $('.mini.modal').modal('show')
}

$(document).ready(function () {
    $('.ui.dropdown').dropdown()
    $('.ui.submit.button').bind('click', function () {
        let opt = $('#opt').val()
        if (!opt)
            msg("未选择计算操作")

        let a = $('#param1').val()
        if (!a)
            msg("未填写参数1")

        let b = $('#param2').val()
        if (!b)
            msg("未填写参数2")

        let url
        if (opt === '1') url = '/add'
        else if (opt === '2') url = '/minus'
        else if (opt === '3') url = '/multi'
        else url = '/divide'
        $.ajax({
            url,
            type: 'post',
            data: {'param1': a, 'param2': b},
            dataType: 'json',
            success: function (response) {
                if (response.code === 0)
                    msg("结果是：" + response.data)
                else
                    msg(response.message)
            },
            error: msg("计算出现错误")
        })
    })
})
