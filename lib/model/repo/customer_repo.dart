
import 'package:get/get.dart';
import 'package:isp_management/model/response/active_customer_model.dart';
import 'package:isp_management/utils/my_image.dart';

class CustomerRepo {

  Future<Response> getActiveCustomer () async {
    try{
      List<ActiveCustomerModel> activeCustomer = [
        ActiveCustomerModel(id: 5001, name: "Kabir",email: "kabir@gmail.com", photo: MyImage.profile, phone: 0185356464 , isActive: true, amount: '500Tk', mbps: 5, address: "House 96, Road 09, Mirpur section 6"),
        ActiveCustomerModel(id: 5002, name: "Abu Taher",email: "abutaher@gmail.com", photo: MyImage.profile1,phone: 01953346634,isActive: true,amount: '800Tk', mbps: 8,address: "House 9, Road 10, Mirpur section 1"),
        ActiveCustomerModel(id: 5010, name: "Rakib", email: "rakib@gmail.com",photo: MyImage.profile2, phone: 017435353 ,isActive: true, amount: '1000Tk', mbps: 10, address: "House 06, Road 09, Mirpur section 6"),
        ActiveCustomerModel(id: 5011, name: "Sourob",email: "sourob@gmail.com", photo: MyImage.profile3, phone: 0124535355 ,isActive: true, amount: '1200Tk', mbps: 12, address: "House 16, Road 01, Mirpur section 2"),
        ActiveCustomerModel(id: 5015, name: "Shila", email: "shila@gmail.com",photo: MyImage.profile4, phone: 01364354366 ,isActive: true, amount: '1500Tk', mbps: 15, address: "House 19, Road 02, Mirpur 12"),
      ];

      Response response = Response(body: activeCustomer, statusCode: 200);
      return response;
    }catch (e) {
      return const Response( statusCode:404,statusText: "Data not found");
    }
  }



  Future<Response> getAllActiveCustomer () async {
    try{
      List<ActiveCustomerModel> allActiveCustomer = [

        ActiveCustomerModel(id: 5001, name: "Kabir",email: "kabir@gmail.com", photo: MyImage.profile, phone: 0185356464 , isActive: true, date: '01-Jan-2023', dueDate: 'Due date: 10-Jan-2023', amount: '500Tk', mbps: 5, address: "House 96, Road 09, Mirpur section 6"),
        ActiveCustomerModel(id: 5002, name: "Abu Taher",email: "abutaher@gmail.com", photo: MyImage.profile1,phone: 01953346634,isActive: false, date: '06-Feb-2023', dueDate: 'Due date: 10-March-2023',amount: '800Tk', mbps: 8,address: "House 9, Road 10, Mirpur section 1"),
        ActiveCustomerModel(id: 5010, name: "Rakib", email: "rakib@gmail.com",photo: MyImage.profile2, phone: 017435353 ,isActive: true, date: '01-March-2023', dueDate: 'Due date: 10-feb-2023',amount: '1000Tk', mbps: 10, address: "House 06, Road 09, Mirpur section 6"),
        ActiveCustomerModel(id: 5011, name: "Sourob",email: "sourob@gmail.com", photo: MyImage.profile3, phone: 0124535355 ,isActive: false, date: '01-April-2023',dueDate: 'Due date: 10-Jan-2023', amount: '1200Tk', mbps: 12, address: "House 16, Road 01, Mirpur section 2"),
        ActiveCustomerModel(id: 5015, name: "Shila", email: "shila@gmail.com",photo: MyImage.profile4, phone: 01364354366 ,isActive: true,date: '01-May-2023', dueDate: 'Due date: 10-feb-2023', amount: '1500Tk', mbps: 15, address: "House 19, Road 02, Mirpur 12"),

        ActiveCustomerModel(id: 50016, name: "Ashek",email: "ashek@gmail.com", photo: MyImage.profile5, phone: 014765757567 , isActive: true, date: '01-Jun-2023', dueDate: 'Due date: 10-April-2023', amount: '1700Tk', mbps: 20, address: " Mohammadpur 6"),
        ActiveCustomerModel(id: 50017, name: "Joy",email: "joy@gmail.com", photo: MyImage.profile6,phone: 01953346634,isActive: false,  date: '01-jan-2023',dueDate: 'Due date: 10-May-2023',amount: '2000Tk', mbps: 25,address: "House 9, Road 10, Shymoli 1"),
        ActiveCustomerModel(id: 5018, name: "Kawsar", email: "kawsar@gmail.com",photo: MyImage.profile7, phone: 017435353 ,isActive: true, date: '01-Feb-2023', dueDate: 'Due date: 10-Jun-2023',amount: '2200Tk', mbps: 30, address: "House 06, Road 09, Uttora section 6"),
        ActiveCustomerModel(id: 5019, name: "Nilima",email: "nilima@gmail.com", photo: MyImage.profile8, phone: 015577575757 ,isActive: false,date: '01-May-2023', dueDate: 'Due date: 10-July-2023', amount: '2500Tk', mbps: 35, address: "House 16, Road 01, Gulishan section 2"),
        ActiveCustomerModel(id: 5020, name: "Michel", email: "michel@gmail.com",photo: MyImage.profile9, phone: 01664464644 ,isActive: true,date: '01-July-2023', dueDate: 'Due date: 10-Dec-2023', amount: '3000Tk', mbps: 40, address: "House 19, Road 02, Gulsan 12"),


      ];

      Response response = Response(body: allActiveCustomer, statusCode: 200);
      return response;
    }catch (e) {
      return const Response( statusCode:404,statusText: "Data not found");
    }
  }



  Future<Response> getTransactionHistory () async {
    try{
      List<ActiveCustomerModel> allActiveCustomer = [
        ActiveCustomerModel(id: 1242, name: "this is demo", photo: '01770066585', date: '09-02-23', isActive: true,amount: '500Tk'),
        ActiveCustomerModel(id: 4242, name: "gwdage", photo: '016464066564', date: '10-09-23',isActive: false, amount: '800Tk'),
        ActiveCustomerModel(id: 1324, name: "done", photo: '0176346464',date: '11-06-23', isActive: true, amount: '1000Tk'),
        ActiveCustomerModel(id: 2425, name: "ok", photo: '01842343535', date: '22-03-23',isActive: false, amount: '1200Tk'),
        ActiveCustomerModel(id: 5356, name: "tester", photo: '0164646066585',date: '29-11-23', isActive: true, amount: '800Tk'),
      ];

      Response response = Response(body: allActiveCustomer, statusCode: 200);
      return response;
    }catch (e) {
      return const Response( statusCode:404,statusText: "Data not found");
    }
  }


  Future<Response> getSupportList () async {
    try{
      List<ActiveCustomerModel> allActiveCustomer = [
        ActiveCustomerModel(id: 834787, name: "Open", photo: '01770066585', date: '09-02-23', isActive: true,amount: '500Tk'),
        ActiveCustomerModel(id: 334787, name: "close", photo: '016464066564', date: '10-09-23',isActive: false, amount: '800Tk'),
        ActiveCustomerModel(id: 814787, name: "Open", photo: '0176346464',date: '11-06-23', isActive: true, amount: '1000Tk'),
        ActiveCustomerModel(id: 866787, name: "Close", photo: '01842343535', date: '22-03-23',isActive: false, amount: '1200Tk'),
        ActiveCustomerModel(id: 534787, name: "Close", photo: '0164646066585',date: '29-11-23', isActive: false, amount: '800Tk'),
      ];

      Response response = Response(body: allActiveCustomer, statusCode: 200);
      return response;
    }catch (e) {
      return const Response( statusCode:404,statusText: "Data not found");
    }
  }

}
