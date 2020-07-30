/*
 * Copyright (C) 2015 Square, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package retrofit2;

import javax.annotation.Nullable;
import okhttp3.Headers;
import okhttp3.Protocol;
import okhttp3.Request;
import okhttp3.ResponseBody;

import static retrofit2.Utils.checkNotNull;

/** An HTTP response. */
public final class Response<T> {
  /** Create a synthetic successful response with {@code body} as the deserialized body. */
  public static <T> Response<T> success(@Nullable T body) {
    return success(body, new okhttp3.Response.Builder() //
        .code(200)
        .message("OK")
        .protocol(Protocol.HTTP_1_1)
        .request(new Request.Builder().url("http://localhost/").build())
        .build());
  }

  /**
   * Create a synthetic successful response with an HTTP status code of {@code code} and
   * {@code body} as the deserialized body.
   */
  public static <T> Response<T> success(int code, @Nullable T body) {
    if (code < 200 || code >= 300) {
      throw new IllegalArgumentException("code < 200 or >= 300: " + code);
    }
    return success(body, new okhttp3.Response.Builder() //
        .code(code)
        .message("Response.success()")
        .protocol(Protocol.HTTP_1_1)
        .request(new Request.Builder().url("http://localhost/").build())
        .build());
  }

  /**
   * Create a synthetic successful response using {@code headers} with {@code body} as the
   * deserialized body.
   */
  public static <T> Response<T> success(@Nullable T body, Headers headers) {
    checkNotNull(headers, "headers == null");
    return success(body, new okhttp3.Response.Builder() //
        .code(200)
        .message("OK")
        .protocol(Protocol.HTTP_1_1)
        .headers(headers)
        .requ