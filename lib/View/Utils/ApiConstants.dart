// const baseUrl = 'https://server-php-7-3.technorizen.com/EalaaDarbik/webservice/';
const baseUrl = 'https://11way.solutions/webservice/';
const baseUrlDriver = 'https://11way.solutions/driver/';
const signup = 'signup';
const login = 'login';
const insertChatMessage = 'insertChatMessage';
const get_conversation = 'get_conversation';
const get_profile = 'get_profile';
const forgot_password = 'forgot_password';
const check_otp = 'check_otp';
const check_whatsapp_otp = 'check_whatsapp_otp';
const signup_whatsapp_resend = 'signup_whatsapp_resend';
const update_password = 'update_password';
const get_companies_list = 'get_companies_list';

const get_drivers_list = 'get_drivers_list';
const get_banner = 'get_banner';
const updateProfile = baseUrl + 'update_user_profile_new';
final privacyPolicy = baseUrl + 'get_privacy';
final aboutUs = baseUrl + 'get_about_us';
final get_company_by_id = 'get_company_by_id';
final get_driver_by_id = 'get_driver_by_id';
final get_nearbuy_company = 'get_nearbuy_company';
final shipment_booking = 'shipment_booking';
final get_city = baseUrlDriver + 'get_city';
final get_countries = baseUrlDriver + 'get_countries';
final get_vehicle_category = baseUrlDriver + 'get_vehicle_category';
final get_shipment_driver = 'get_shipment_driver';
final get_shipment_list = baseUrl + 'get_shipment_list';
final add_driver_approve = baseUrl + 'add_driver_approve';
final get_shipment_ongoing_start = baseUrl + 'get_shipment_ongoing_start';
final get_approve_shipment_details = 'get_approve_shipment_details';
final get_nearbuy_shipment = 'get_nearbuy_shipment';
final update_payment_status = "update_payment_status";
final get_notification = "get_notification";
final notification_count = "notification_count";
final insert_chat = baseUrl + "insert_chat";
final get_nearby_drivers = baseUrl + "get_nearby_drivers";
final update_notification_onoff = baseUrl + "update_notification_onoff";
final getDriverLatLong = baseUrl + "getlatlon";
final otp_expire = "otp_expire";

//store
final get_category = 'get_category';
final get_banner_product = "get_store_banner";
final get_store_by_category = "get_store_by_category";
final get_product_by_store = baseUrl + "get_product_by_store";
final get_product_by_category = "get_product_by_category";
final get_product_details = "get_product_details";
final add_to_wishlist = baseUrl + "add_to_wishlist";
final get_wishlist = baseUrl + "get_wishlist";
final add_to_cart = baseUrl + "add_to_cart";
final get_cart = baseUrl + "get_cart";
final delete_cart_data = baseUrl + "delete_cart_data";
final add_address = baseUrl + "add_address";
final get_address = baseUrl + "get_address";
final place_order = baseUrl + "place_order";
final get_user_order_details = baseUrl + "get_user_order_details";
final get_store_payment = baseUrl + "get_store_payment";

//advertisement
const get_advertise_banner = 'get_advertise_banner';
const get_all_advertisement_posts = 'get_all_advertisement_posts';
const get_advertisement_category_post = 'get_advertisement_category_post';
const get_ads_with_category_home = 'get_ads_with_category_home';
const advertisement_post_fav = 'advertisement_post_fav';
const get_advertisement_details = 'get_advertisement_details';
const get_ads_post_details = 'get_ads_post_details';
const ads_post_details_favourite = 'ads_post_details_favourite';
const get_advertisement_posts_category = 'get_advertisement_posts_category';
const get_advertisement_posts = 'get_advertisement_posts';
const get_landlord = 'get_landlord';
const get_occupancy_status = 'get_occupancy_status';
const get_retail = 'get_retail';
const get_advertisement_category = 'get_advertisement_category';
const get_ads_my_post = 'get_ads_my_post';
const get_advertisement_sub_category = 'get_advertisement_sub_category';
const get_ads_with_category_subcategory = 'get_ads_with_category_subcategory';
//const add_advertisement_posts = baseUrl+'add_advertisement_posts';
const add_advertisement_CommercialPlot_posts = baseUrl+'add_advertisement_CommercialPlot_posts';
const add_advertisement_CommercialVilla_posts = baseUrl+'add_advertisement_CommercialVilla_posts';
const add_advertisement_MotorsPlates_posts = baseUrl+'add_advertisement_MotorsPlates_posts';
const add_advertisement_Motors_Auto_Accessories_posts = baseUrl+'add_advertisement_Motors_Auto_Accessories_posts';
const add_advertisement_Motors_BoatsYachts_posts = baseUrl+'add_advertisement_Motors_BoatsYachts_posts';
const add_advertisement_Motorbike_posts = baseUrl+'add_advertisement_Motorbike_posts';
const add_advertisement_TrucksHeavyVehicles_posts = baseUrl+'add_advertisement_TrucksHeavyVehicles_posts';
const add_advertisement_Cars_posts = baseUrl+'add_advertisement_Cars_posts';
const add_advertisement_Classified_Cycling_posts = baseUrl+'add_advertisement_Classified_Cycling_posts';
const get_maker_model = baseUrl+'get_maker_model';
const get_make_filter = baseUrl+'get_make_filter';
const get_model_filter = baseUrl+'get_model_filter';
const get_model_trim_filter = baseUrl+'get_model_trim_filter';
const get_year_filter = baseUrl+'get_year_filter';
const get_condition_filter = baseUrl+'get_condition_filter';
const get_EngineSize_filter = baseUrl+'get_EngineSize_filter';
const get_DoorCount_filter = baseUrl+'get_DoorCount_filter';
const get_interiorColor_filter = baseUrl+'get_interiorColor_filter';
const get_cylinders_filter = baseUrl+'get_cylinders_filter';
const get_fuel_filter = baseUrl+'get_fuel_filter';
const get_transmission_filter = baseUrl+'get_transmission_filter';
const get_drivetrain_filter = baseUrl+'get_drivetrain_filter';
const get_seats_filter = baseUrl+'get_seats_filter';
const get_plate_filter = baseUrl+'get_plate_filter';
const get_origin_filter = baseUrl+'get_origin_filter';
const get_governate_filter = baseUrl+'get_governate_filter';
const get_states_filter = baseUrl+'get_states_filter';
const get_exteriorColor_filter = baseUrl+'get_exteriorColor_filter';
const get_electronics_brand_filter = baseUrl+'get_electronics_brand_filter';
const get_electronics_condition_filter = baseUrl+'get_electronics_condition_filter';
const get_number_type = baseUrl+'get_number_type';
const get_operators = baseUrl+'get_operators';
const upload_vehicle_buy = baseUrl+'upload_vehicle_buy';
const uploadElectronics_sell = baseUrl+'uploadElectronics_sell';
const uploadElectronics_buy = baseUrl+'uploadElectronics_buy';
const upload_vehicle_sell = baseUrl+'upload_vehicle_sell';
const edit_vehicle_sell = baseUrl+'edit_vehicle_sell';
const edit_vehicle_buy = baseUrl+'edit_vehicle_buy';
const get_real_state = baseUrl+'get_real_state';
const upload_real_state_buy = baseUrl+'upload_real_state_buy';
const upload_real_state_sell = baseUrl+'upload_real_state_sell';
const edit_real_state = baseUrl+'edit_real_state';
const edit_electronics = baseUrl+'edit_electronics';
const upload_vehicles_parts_accessories_sale = baseUrl+'upload_vehicles_parts_accessories_sale';
const upload_vehicles_parts_accessories_wanted = baseUrl+'upload_vehicles_parts_accessories_wanted';
const edit_vehicle_part = baseUrl+'edit_vehicle_part';
const upload_vehicles_numbers_for_sale = baseUrl+'upload_vehicles_numbers_for_sale';
const upload_vehicles_numbers_for_rent = baseUrl+'upload_vehicles_numbers_for_rent';
const upload_vehicles_numbers_for_wanted = baseUrl+'upload_vehicles_numbers_for_wanted';
const edit_vehicles_numbers = baseUrl+'edit_vehicles_numbers';
const get_electronics = baseUrl+'get_electronics';
const get_animals = baseUrl+'get_animals';
const upload_animals_sell = baseUrl+'upload_animals_sell';
const edit_animals = baseUrl+'edit_animals';
const get_phone_number = baseUrl+'get_phone_number';
const upload_phone_number_sell = baseUrl+'upload_phone_number_sell';
const edit_phone_number = baseUrl+'edit_phone_number';
const get_vehicles_parts_accessories_wanted = baseUrl+'get_vehicles_parts_accessories_wanted';
const get_vehicles_parts_accessories_for_sell = baseUrl+'get_vehicles_parts_accessories_for_sell';
const get_vehicles_numbers_for_sell = baseUrl+'get_vehicles_numbers_for_sell';
const get_vehicles_numbers_for_rent = baseUrl+'get_vehicles_numbers_for_rent';
const get_vehicles_numbers_for_wanted = baseUrl+'get_vehicles_numbers_for_wanted';






