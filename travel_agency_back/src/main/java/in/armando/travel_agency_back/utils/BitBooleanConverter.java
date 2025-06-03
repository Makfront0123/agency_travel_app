package in.armando.travel_agency_back.utils;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;

@Converter(autoApply = true)
public class BitBooleanConverter implements AttributeConverter<Boolean, Byte> {

    @Override
    public Byte convertToDatabaseColumn(Boolean attribute) {
        if (attribute == null) return 0;
        return (byte) (attribute ? 1 : 0);
    }

    @Override
    public Boolean convertToEntityAttribute(Byte dbData) {
        return dbData != null && dbData == 1;
    }
}
