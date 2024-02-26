<?php

namespace app\admin\controller;

use app\admin\model\AdminLog;

class Index extends Base
{
    protected $adminAuthGroup;
    protected $adminAuthRule;
    protected $admin;
    protected $currentRole;
    protected $adminAuth;
    protected $role;
    protected $aid;

    public function initialize()
    {
        parent::initialize(); // TODO: Change the autogenerated stub
        $this->adminAuthGroup = model('admin/AdminAuthGroup');
        $this->admin = model('admin/Admin');
        $this->adminAuthRule = model('admin/AdminAuthRule');
        $this->adminAuth = session('admin_auth');
        $this->currentRole = $this->adminAuth['current_role'];
        $role = $this->adminAuth['role_id'];
        $this->role = explode(',', $role);
        $this->aid = get_aid();
    }

    public function index()
    {
        AdminLog::setTitle('后台首页');
       return $this->fetch();
    }

    /**
     * 弹出更多信息
     * @author:wdx(wdx@ourstu.com)
     */
    public function showMore()
    {
        $roles = $this->adminAuthGroup->whereIn('id', $this->role)->where('status', 1)->column('title', 'id');
        $this->assign('roles', $roles);
        $this->assign('currentRole', $this->currentRole);
        echo $this->fetch();
    }

    /**
     * 身份切换
     * @author:wdx(wdx@ourstu.com)
     */
    public function changeRole()
    {
        $id = input('id/d', 0);
        if (in_array($id, $this->role)) {
            $rs = $this->admin->where('id', $this->aid)->setField('current_group', $id);
            if ($rs) {
                cache('menu', null);
                cache('nav', null);
                $newAdminAuth = $this->adminAuth;
                $newAdminAuth['current_role'] = $id;
                session('admin_auth', $newAdminAuth);
                session('admin_auth_sign', data_auth_sign($newAdminAuth));
                AdminLog::setTitle('身份切换');
                $this->success('身份切换成功', 'admin/index/index');
            }
            $this->error('身份切换失败');
        }
        $this->error('非法操作，身份切换失败');
    }

    /**
     * 主题色切换
     * @author:wdx(wdx@ourstu.com)
     */
    public function theme()
    {
        echo $this->fetch();
    }

    /**
     * 菜单搜索
     * @param string $keywords
     * @author:wdx(wdx@ourstu.com)
     */
    public function search($keywords = '')
    {
        if ($this->adminAuth['rules'] !== '*') {
            $map[] = ['id', 'in', $this->adminAuth['rules']];
        }
        $map[] = ['title', 'like', '%' . $keywords . '%'];
        $map[] = ['is_menu', '=', 1];
        $map[] = ['is_show', '=', 1];
        $map[] = ['pid', '<>', 0];
        $data = $this->adminAuthRule->where($map)->select();
        foreach ($data as &$val) {
            $val['icon'] = '<i class="layui-icon ' . $val['icon'] . '"></i>';
        }
        $count = count($data);
        $this->assign('data', $data);
        $this->assign('count', $count);
        $this->assign('keywords', $keywords);
        AdminLog::setTitle('菜单搜索');
        return $this->fetch();
    }

    public function console()
    {
        AdminLog::setTitle('仪表盘');
        return  $this->fetch();
    }

    public function timePicker()
    {
        return $this->fetch();
    }
}
