$(function(){
    // 一次性初始化所有弹出框
    $('[data-toggle="popover"]').popover();

    // 图片lazyload
    $('img.lazy').lazyload({
        effect         : 'fadeIn',
        data_attribute : 'src',
        placeholder    : $('#corethink_home_img').val()+'/default/default.gif'
    });

    // 刷新验证码
    $(document).on('click', '.reload-verify', function() {
        var verifyimg = $(this).attr("src");
        if (verifyimg.indexOf('?') > 0) {
            $(this).attr("src", verifyimg + '&random=' + Math.random());
        } else {
            $(this).attr("src", verifyimg.replace(/\?.*$/, '') + '?' + Math.random());
        }
    });

    //全选/反选/单选的实现
    $(document).on('click', '.check-all', function() {
        $(".ids").prop("checked", this.checked);
    });

    $(document).on('click', '.ids', function() {
        var option = $(".ids");
        option.each(function() {
            if (!this.checked) {
                $(".check-all").prop("checked", false);
                return false;
            } else {
                $(".check-all").prop("checked", true);
            }
        });
    });

    //搜索功能
    $(document).on('click', '.search-btn', function() {
        var url = $(this).closest('form').attr('action');
        var query = $(this).closest('form').serialize();
        query = query.replace(/(&|^)(\w*?\d*?\-*?_*?)*?=?((?=&)|(?=$))/g, '');
        query = query.replace(/(^&)|(\+)/g, '');
        if (url.indexOf('?') > 0) {
            url += '&' + query;
        } else {
            url += '?' + query;
        }
        window.location.href = url;
        return false;
    });

    //回车搜索
    $(document).on('keydown', '.search-input', function(e) {
        if (e.keyCode === 13) {
            $(this).closest('form').find('.search-btn').click();
            return false;
        }
    });


    // 设置ct-tab的宽度
    $('.ct-tab').width($(window).width()-373);

    // 打开新Tab
    $(document).on('click', '#sidebar .open-tab', function() {
        var tab_url   = $(this).attr('href');
        var tab_name  = $(this).attr('tab-name');
        var is_open   = $('.ct-tab-content #' + tab_name).length;
        if(is_open !== 0){
            $('.ct-tab a[href=#' + tab_name + ']').tab('show');
        } else {
            var tab  = '<li class="new-add" style="position: relative;float:left;display: inline-block;"><a href="#'
                     + tab_name
                     + '" role="tab" data-toggle="tab">'
                     + $(this).html()
                     + '<button type="button" class="close" aria-label="Close">'
                     + '<span aria-hidden="true">&times;</span></button></a></li>';
            var tab_content = '<div role="tabpanel" class="new-add tab-pane fade" id="'
                            + tab_name
                            + '"><iframe name="#'
                            + tab_name
                            + '" class="iframe" src="'
                            + tab_url
                            +'"></iframe></div>';
            $('.ct-tab').width($('.ct-tab').width() + 60);
            $('.ct-tab').append(tab);
            $('.ct-tab-content').append(tab_content);
            $('.ct-tab a:last').tab('show');
        }
        return false;
    });

    // 关闭标签时自动取消左侧导航的active状态
    $(document).on('click', '.nav-close .close', function() {
        var id  = $(this).closest('a[data-toggle="tab"]').attr('href');
        var tab = id.split('#');
        $('a[tab-name=' + tab[1] + ']').closest('li').removeClass('active');
    });

    // 关闭所有标签
    $(document).on('click', '.close-all', function() {
        $('.new-add').remove();
        $('.ct-tab a:first').tab('show');
    });

    // 双击刷新标签
    $(document).on('dblclick', '.ct-tab a', function() {
        var id = $(this).attr('href');
        $(id+' .iframe').attr('src', $(id+' .iframe').attr('src'));
    });

    // TAB向左滚动
    $(document).on('click', '#tab-left', function() {
        var left = $('.ct-tab').position().left;
        if (left < 0) {
            $('.ct-tab').animate({left:(left+480+'px')});
        }
    });

    // TAB向右滚动
    $(document).on('click', '#tab-right', function() {
        var left = $('.ct-tab').position().left;
        if(($(window).width()-373)-(left+$('.ct-tab').width()) < 0){
            $('.ct-tab').animate({left:(left-480+'px')});
        }
    });

});
