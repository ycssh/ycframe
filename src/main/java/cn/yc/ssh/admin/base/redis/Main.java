package cn.yc.ssh.admin.base.redis;

import java.util.concurrent.atomic.AtomicInteger;

import org.apache.shiro.cache.Cache;

public class Main {

	public static void main(String[] args) {
		RedisCacheManager rcm = new RedisCacheManager();
		Cache<String, AtomicInteger> cache = rcm.getCache("passwordRetryCache");
		cache.put("ycssh", new AtomicInteger(100));
		System.out.println(cache.get("ycssh"));
	}

}
