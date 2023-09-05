package com.lwl.pdfgensvc;

import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.databind.JsonSerializer;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializerProvider;
import com.fasterxml.jackson.databind.module.SimpleModule;
import com.fasterxml.jackson.databind.ser.std.NullSerializer;

import java.io.IOException;

public class DoubleSerializationExample {
    public static void main(String[] args) throws Exception {
        ObjectMapper objectMapper = new ObjectMapper();

        // Create a custom module to handle double serialization
        SimpleModule module = new SimpleModule();
        module.addSerializer(Double.class, new CustomDoubleSerializer());
        objectMapper.registerModule(module);

        // Create an object with double values
        MyObject myObject = new MyObject();
        myObject.setValue1(0.0000123456789);
        myObject.setValue2(123456.789);

        // Serialize the object to JSON
        String json = objectMapper.writeValueAsString(myObject);
        System.out.println(json);
    }

    // Custom serializer for double values
    static class CustomDoubleSerializer extends JsonSerializer<Double> {
        @Override
        public void serialize(Double value, JsonGenerator gen, SerializerProvider serializers) throws IOException {
            // Customize the formatting of the double value here
            gen.writeString(String.valueOf(value));
        }
    }

    // Example object with double values
    static class MyObject {
        private double value1;
        private double value2;

        public double getValue1() {
            return value1;
        }

        public void setValue1(double value1) {
            this.value1 = value1;
        }

        public double getValue2() {
            return value2;
        }

        public void setValue2(double value2) {
            this.value2 = value2;
        }
    }
}