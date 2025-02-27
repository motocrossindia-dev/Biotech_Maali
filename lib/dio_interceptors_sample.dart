// import 'package:dio/dio.dart';

// class ApiService {
//   final Dio dio = Dio(BaseOptions(
//     baseUrl: "https://jsonplaceholder.typicode.com",
//     connectTimeout: Duration(seconds: 10),
//     receiveTimeout: Duration(seconds: 10),
//   ));

//   ApiService() {
//     dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) {
//           // Log request details
//           print("Request: ${options.method} ${options.uri}");
//           print("Headers: ${options.headers}");
//           print("Body: ${options.data}");
          
//           // Add Authorization header dynamically
//           options.headers["Authorization"] = "Bearer YOUR_ACCESS_TOKEN";

//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           // Log response details
//           print("Response: ${response.statusCode}");
//           print("Data: ${response.data}");

//           return handler.next(response);
//         },
//         onError: (DioException e, handler) {
//           // Log error details
//           print("Error: ${e.message}");
//           print("Response: ${e.response?.data}");

//           // Retry request if it fails due to timeout
//           if (e.type == DioExceptionType.connectionTimeout) {
//             print("Retrying request...");
//             return handler.resolve(dio.request(e.requestOptions.path, options: e.requestOptions));
//           }

//           return handler.next(e);
//         },
//       ),
//     );
//   }

//   Future<List<dynamic>> getPosts() async {
//     try {
//       Response response = await dio.get("/posts");
//       return response.data;
//     } catch (e) {
//       throw Exception("Failed to fetch posts: $e");
//     }
//   }
// }
