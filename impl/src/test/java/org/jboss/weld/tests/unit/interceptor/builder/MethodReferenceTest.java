/*
 * JBoss, Home of Professional Open Source
 * Copyright 2012, Red Hat, Inc., and individual contributors
 * by the @authors tag. See the copyright.txt in the distribution for a
 * full listing of individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.jboss.weld.tests.unit.interceptor.builder;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.Method;

import org.jboss.weld.interceptor.builder.MethodReference;
import org.junit.Test;

/**
 *
 */
public class MethodReferenceTest {



    @Test
    public void testSerializationOfMethodWithPrimitiveLongParameter() throws Exception {
        Method method = MethodReferenceTest.class.getDeclaredMethod("someMethod", long.class);
        MethodReference reference = MethodReference.of(method, false);

        deserialize(serialize(reference));


    }

    private Object deserialize(byte[] serialized) throws Exception{
        ByteArrayInputStream bais = new ByteArrayInputStream(serialized);
        ObjectInputStream ois = new ObjectInputStream(bais);
        try {
            return ois.readObject();
        } finally {
            ois.close();
        }
    }

    private byte[] serialize(MethodReference reference) throws IOException {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ObjectOutputStream oos = new ObjectOutputStream(baos);
        oos.writeObject(reference);
        oos.flush();
        return baos.toByteArray();
    }

    public void someMethod(long param) {
    }
}
