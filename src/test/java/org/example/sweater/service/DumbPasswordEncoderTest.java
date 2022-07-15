package org.example.sweater.service;

import junit.framework.TestCase;
import org.hamcrest.Matchers;
import org.junit.Assert;

public class DumbPasswordEncoderTest extends TestCase {

    public void testEncode() {
        DumbPasswordEncoder dumbPasswordEncoder = new DumbPasswordEncoder();
        Assert.assertEquals("Secret, 'mypwd'", dumbPasswordEncoder.encode("mypwd"));
        Assert.assertThat(dumbPasswordEncoder.encode("mypwd"), Matchers.containsString("mypwd"));

    }
}