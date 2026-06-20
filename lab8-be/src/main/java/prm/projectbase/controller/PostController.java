package prm.projectbase.controller;

import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.web.bind.annotation.*;
import prm.projectbase.dto.request.PostCreateRequest;
import prm.projectbase.dto.response.BaseResponse;
import prm.projectbase.dto.response.PostResponse;
import prm.projectbase.service.PostService;

import java.util.List;

@RestController
@RequestMapping("/api/v1/public/posts")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE, makeFinal = true)
public class PostController {

    PostService postService;

    @GetMapping
    public BaseResponse<List<PostResponse>> getAllPosts() {
        return BaseResponse.success(postService.getAllPosts());
    }

    @PostMapping
    public BaseResponse<PostResponse> createPost(@RequestBody @Valid PostCreateRequest request) {
        return BaseResponse.success(postService.createPost(request));
    }
}
