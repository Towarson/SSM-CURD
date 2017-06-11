package com.ssm.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 *  通用的返回信息
 * @author Towarson
 * @Date 2017年5月19日
 * @version 1.0
 */
public class Msg {
	//状态码 100-成功;200-失败
	private int code;
	
	//提示信息
	private String msg;
	
	private Map<String, Object> extend = new HashMap<String, Object>();

	//成功！
	public static Msg success() {
		Msg sucess = new Msg();
		sucess.setCode(100);
		sucess.setMsg("操作成功!");
		return sucess;
	}
	
	//失败
	public static Msg fail() {
		Msg fail = new Msg();
		fail.setCode(200);
		fail.setMsg("操作失败!");
		return fail;
	}
	
	public Msg add(String key,Object value) {
		this.getExtend().put(key, value);
		return this;
	}
	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
	
	
}
