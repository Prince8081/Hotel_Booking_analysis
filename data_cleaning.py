import pandas as pd 

df = pd.read_csv('hotel_bookings.csv')

# Fill missing children values with 0

df['children'] = df['children'].fillna(0)

# Drop 'company' column

df = df.drop(columns=['company'])

# Create New Columns

# Total guests = adults + children + babies

df['total_guest'] = (df['adults']+df['children']+df['babies']).astype(int)

# Total nights stayed = weekend + week nights

df['total_stays'] = df['stays_in_weekend_nights'] + df['stays_in_week_nights']

# Revenue (approx) = adr * total_stays

df['revenue'] = df['adr']*df['total_stays']

# Convert Data Types

# Convert reservation_status_date to datetime

df['reservation_status_date'] = pd.to_datetime(df['reservation_status_date'])


df['agent'] = df['agent'].fillna(0)
df['agent'] = df['agent'].astype(int)


# Remove rows where adr < 0

df = df[df['adr'] >= 0 ]


# Binary columns to Yes/No

df['is_canceled'] = df['is_canceled'].replace({0:'No' , 1 : 'Yes'})
df['is_repeated_guest'] = df['is_repeated_guest'].replace({0:'No' , 1 : 'Yes'})

# Parking column to text

# Replace required_car_parking_spaces: 0 = No Parking, >0 = Parking Requested

df['required_car_parking_spaces'] = df['required_car_parking_spaces'].apply(
    lambda X : "No Parking" if X == 0  else "Parking Requested")


# Replace total_of_special_requests: 0 = None, keep number otherwise

df['total_of_special_requests'] = df['total_of_special_requests'].apply(
    lambda X: 'None' if X == 0 else str(X) + "Request")

print(df.head(15))

df.to_csv("hotel_bookings_clean.csv", index=False)

print("✅ Master Cleaning Complete! File saved as hotel_bookings_clean_final.csv")
